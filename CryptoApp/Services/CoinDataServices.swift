//
//  CoinData.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/13/24.
//
import Foundation
import Combine

class CoinDataServices {
    
    @Published var alltCoin: [CoinModel] = []
    private var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
     func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=250&sparkline=true&price_change_percentage=24h") else {
            print("Error in URL Section")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("CG-9x6QTSjZjLfcvZKBeqwGGfGQ", forHTTPHeaderField: "x-cg-demo-api-key")
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self](returnCoin) in
                self?.alltCoin = returnCoin
                self?.coinSubscription?.cancel()
            })
        
    }
}
