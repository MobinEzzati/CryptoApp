//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/12/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var statistics:[StatisticModel] = [
        StatisticModel(title: "title", value: "value", percentageChange: 1),
        StatisticModel(title: "title", value: "value"),
        StatisticModel(title: "title", value: "value"),
        StatisticModel(title: "title", value: "value", percentageChange: -3)


      ]
    
    @Published var alltcoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchedText: String = ""
    @Published var isLoading = false
    @Published var sortOption: SortOptions = .holdings
    
    private var cancellables = Set<AnyCancellable>()
    private let coinDataService = CoinDataServices()
    private let portfolioDataservice = PortfolioDataService()
    private let marketDataService = MarketDataService()
    
    
    static let homeVM = HomeViewModel()
    enum SortOptions {
        case rank, rankReversed, holdings, holdingReversed, price, priceReversed
    }
    init() {
        print("test")
        addSubscribers()
    }
    

    
    private func addSubscribers() {

        // update and receive alltcoins

        $searchedText
            .combineLatest(coinDataService.$alltCoin, $sortOption)
                     .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main) // 500 milliseconds debounce
                     .map(filterAndSortCoins)
                     .sink { [weak self] filteredCoins in
                         self?.alltcoins = filteredCoins
                     }
                     .store(in: &cancellables)
        
        // update portfolio coins section
        $alltcoins
            .combineLatest(portfolioDataservice.$savedEntities)
            .map ( mapAllcoinsToPortfolioCoins)
            
            .sink { [weak self] coinModel in
                guard let self = self else {return}
                
                
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: coinModel)
                
            }.store(in: &cancellables)
        
        
        
        
        // update top bar of market data
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarket)
           .sink { [weak self] (returnStats) in
               
                self?.statistics  = returnStats
               self?.isLoading = false 
            }
            .store(in: &cancellables)
        
 
    }
    
    
    func updatePortfolio(coin:CoinModel, amount: Double) {
        portfolioDataservice.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterAndSortCoins(text:String, coins:[CoinModel] , sort: SortOptions) -> [CoinModel] {
        
        var updatedCoins = filterCoins(text: text, startingCoin: coins)
         sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    
    
    private func filterCoins(text:String, startingCoin:[CoinModel]) -> [CoinModel] {
        
        
        guard !text.isEmpty else {
            return startingCoin
        }
        
        let loweredCases = text.lowercased()
        return startingCoin.filter { coinModel -> Bool in
            return coinModel.name.lowercased().contains(loweredCases) ||
            coinModel.symbol.lowercased().contains(loweredCases) ||
            coinModel.id.lowercased().contains(loweredCases)
            
        }
        
    }
    
    private func sortCoins(sort: SortOptions, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings :
            return coins.sort(by: {$0.rank < $1.rank})
            
        case .rankReversed , .holdingReversed:
             
            return coins.sort { coin1, coin2 in
                return coin1.rank > coin2.rank
            }


        case .price:
            return coins.sort{ coin1, coin2 in
                return coin1.currentPrice < coin2.currentPrice
            }
        case .priceReversed:
            return coins.sort { coin1, coin2 in
                return coin1.currentPrice > coin2.currentPrice
            }
        }
    }
    
    func reloadData() {
        isLoading = true
        marketDataService.getCoins()
        coinDataService.getCoins()
        HapticManager.shared.triggerImpactFeedback(style: .success)
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {

        case .holdings:
            return coins.sorted(by: {$0.currentHoldingValue > $1.currentHoldingValue})
        case .holdingReversed:
            return coins.sorted(by: {$0.currentHoldingValue < $1.currentHoldingValue})
        default:
            return coins
        }
    }
    
    
    
    private func mapAllcoinsToPortfolioCoins(allCoins:[CoinModel], portfolioEntities:[PortfolioEntity]) -> [CoinModel]{
        allCoins.compactMap { (coin) -> CoinModel? in
            guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                return nil
            }
            return coin.updateHoldingModel(amount: entity.amount)
        }
    }
    
    
    private func mapGlobalMarket(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel] ) -> [StatisticModel] {
        
        
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        stats.append(marketCap)
        
        let volume = StatisticModel(title: "24H Volume", value: data.marketVolume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        
        let portfolioValue = portfolioCoins
            .map ({$0.currentHoldingValue})
            .reduce(0, +)
        
        
        let previousValue = portfolioCoins.map { coinModel -> Double in
            let currentValue = coinModel.currentHoldingValue
            let percentChange = coinModel.priceChangePercentage24h / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }.reduce(0.0, +)
        
        let percentChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith6Decimal(), percentageChange: percentChange)

        
        stats.append(volume)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        
        ])
        
        
        return stats
    }
     
}
