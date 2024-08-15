//
//  CoinLogoView.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 8/8/24.
//

import SwiftUI

struct CoinLogoView: View {
    let coinModel: CoinModel
    var body: some View {
     
        VStack {
            
            CoinImageView(url: URL(string: coinModel.image))
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            Text(coinModel.symbol.uppercased())
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(1)
                .minimumScaleFactor(1.0)
                .multilineTextAlignment(.center)
            
            Text(coinModel.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                .minimumScaleFactor(1.0)
                .multilineTextAlignment(.center)

        }

    }
}

#Preview {
    Group {
//        CoinLogoView(coinModel: CoinModel.defualtCoin)
        CoinLogoView(coinModel: CoinModel.defualtCoin)
            .preferredColorScheme(.dark)
            
    }
}
