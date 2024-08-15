//
//  Color.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 5/29/24.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme{
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let greenColor = Color("g")
    let red = Color("r")
    let secondaryText = Color("SecondaryTextColor")
}
