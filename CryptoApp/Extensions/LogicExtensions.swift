//
//  ViewExtensions.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/9/24.
//

import Foundation

extension Double {
    var currnecyFormater: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ","
        
        return formatter
    }
    
    func asCurrencyWith6Decimal() ->String {
        let number = NSNumber(value: self)
        return currnecyFormater.string(from: number) ?? "0.00"
    }
    
    func asStringNumber() ->String{
        return String(format:"%.2f", self)
    }
    
    func asPercent() -> String {
        
        return asStringNumber() + "%"
    }
    
    func formattedWithAbbreviations() -> String {
            let num = abs(Double(self))
            let sign = (self < 0) ? "-" : ""

            switch num {
            case 1_000_000_000_000...:
                let formatted = num / 1_000_000_000_000
                let stringFormatted = formatted.asStringNumber()
                return "\(sign)\(stringFormatted)Tr"
            case 1_000_000_000...:
                let formatted = num / 1_000_000_000
                let stringFormatted = formatted.asStringNumber()
                return "\(sign)\(stringFormatted)Bn"
            case 1_000_000...:
                let formatted = num / 1_000_000
                let stringFormatted = formatted.asStringNumber()
                return "\(sign)\(stringFormatted)M"
            case 1_000...:
                let formatted = num / 1_000
                let stringFormatted = formatted.asStringNumber()
                return "\(sign)\(stringFormatted)K"
            case 0...:
                return self.asStringNumber()

            default:
                return "\(sign)\(self)"
            }
        }
}
