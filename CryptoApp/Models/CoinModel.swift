//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/6/24.
//

import Foundation
/*
{
   "id": "bitcoin",
   "symbol": "btc",
   "name": "Bitcoin",
   "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
   "current_price": 1,
   "market_cap": 19719618,
   "market_cap_rank": 1,
   "fully_diluted_valuation": 21000000,
   "total_volume": 336373,
   "high_24h": 1,
   "low_24h": 1,
   "price_change_24h": 0,
   "price_change_percentage_24h": 0,
   "market_cap_change_24h": 68,
   "market_cap_change_percentage_24h": 0.00034,
   "circulating_supply": 19719618,
   "total_supply": 21000000,
   "max_supply": 21000000,
   "ath": 1.003301,
   "ath_change_percentage": -0.32896,
   "ath_date": "2019-10-15T16:00:56.136Z",
   "atl": 0.99895134,
   "atl_change_percentage": 0.10498,
   "atl_date": "2019-10-21T00:00:00.000Z",
   "roi": null,
   "last_updated": "2024-07-07T06:15:24.173Z",
   "sparkline_in_7d": {
     "price": [
       60677.18706977532,
       61152.87602142954,
       61455.12330484647,
     ]
   },
   "price_change_percentage_24h_in_currency": 0
 }


*/

/*
 
 URL: http GET 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=btc&per_page=250&sparkline=true&price_change_percentage=24h' \
 accept:application/json \
 x-cg-demo-api-key:CG-9x6QTSjZjLfcvZKBeqwGGfGQ
*/




struct CoinModel: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double
    let marketCapRank: Int
    let fullyDilutedValuation: Double?
    let totalVolume: Double
    let high24h: Double
    let low24h: Double
    let priceChange24h: Double
    let priceChangePercentage24h: Double
    let marketCapChange24h: Double
    let marketCapChangePercentage24h: Double
    let circulatingSupply: Double
    let totalSupply: Double?
    let maxSupply: Double?
    let ath: Double
    let athChangePercentage: Double
    let athDate: String
    let atl: Double
    let atlChangePercentage: Double
    let atlDate: String
    let lastUpdated: String
    let sparklineIn7D: SparklineIn7D
    let priceChangePercentage24hInCurrency: Double?
    let currentHoldings: Double?
    
    static let defualtCoin = CoinModel(id: "bitcoin",
                                       symbol: "btc",
                                       name: "Bitcoin",
                                       image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
                                       currentPrice: 1971,
                                       marketCap: 19719618,
                                       marketCapRank: 1,
                                       fullyDilutedValuation: 21000000,
                                       totalVolume: 336373,
                                       high24h: 1,
                                       low24h: 1,
                                       priceChange24h: 0, 
                                       priceChangePercentage24h: 0, marketCapChange24h: 68, marketCapChangePercentage24h: 0.00034, circulatingSupply: 19719618,
                                           totalSupply: 21000000,
                                       maxSupply: 21000000,
                                       ath: 1.003301,
                                       athChangePercentage: -0.32896,
                                       athDate: "2019-10-15T16:00:56.136Z",
                                       atl: 0.99895134,
                                       atlChangePercentage: -0.32896,
                                       atlDate: "2019-10-21T00:00:00.000Z",
                                       lastUpdated: "2024-07-07T06:15:24.173Z",
                                       sparklineIn7D: SparklineIn7D(price:  [
                                        60677.18706977532,
                                        61152.87602142954,
                                        61455.12330484647,
                                      ]),
                                       priceChangePercentage24hInCurrency: 0,
                                       currentHoldings: 4.4)

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24hInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldingModel(amount:Double) -> CoinModel {
        
        
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24h: high24h, low24h: low24h, priceChange24h: priceChange24h, priceChangePercentage24h: priceChangePercentage24h, marketCapChange24h: marketCapChange24h, marketCapChangePercentage24h: marketCapChangePercentage24h, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: athDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24hInCurrency: priceChangePercentage24hInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingValue: Double {
        
        return(currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCap)
    }
}

// MARK: - SparklineIn7D Model
struct SparklineIn7D: Codable {
    let price: [Double]
}
