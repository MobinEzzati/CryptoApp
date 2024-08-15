//
//  StatisticModel.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/19/24.
//

import Foundation


struct StatisticModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let value: String
    let percentageChange: Double?
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
    
    static let stat1 = StatisticModel(title: "Market Cap", value: "$12. 5B", percentageChange: 25.34)
    static let stat2 = StatisticModel(title: "Total Volume ", value: "$1.23Tr")
    static let stat3 = StatisticModel(title: "Portfolio Value", value: "$12. 5B", percentageChange: -12.34)
   
}



