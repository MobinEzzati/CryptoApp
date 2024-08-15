//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/8/24.
//

import SwiftUI

struct CoinRowView: View {
    let coinModel: CoinModel
    let showHoldingColumn: Bool
    static let imageCache = NSCache<NSString, UIImage>()
    
    var body: some View {
        HStack(spacing: 0) {
            leftSection
            Spacer()
            if showHoldingColumn {
                holdingColumn
                Spacer()
            }
            rightSection
        }
        .background(Color.theme.background)
        .font(.subheadline)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.theme.accent, lineWidth: 2)
        )
        .cornerRadius(10)
        .padding(.vertical, 4)
        .padding(.horizontal)
        .listRowBackground(Color.theme.background)
        .listRowInsets(EdgeInsets())
    }
}

#Preview {
    Group {
        CoinRowView(coinModel: CoinModel.defualtCoin, showHoldingColumn: true)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
                   
        CoinRowView(coinModel: CoinModel.defualtCoin, showHoldingColumn: false)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

extension CoinRowView {
    private var leftSection: some View {
        HStack(spacing: 3) {
            CoinImageView(url: URL(string: coinModel.image))
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            Text(coinModel.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
        }
        .padding(.leading, 6)
    }

    private var holdingColumn: some View {
        VStack(alignment: .trailing) {
            Text(coinModel.currentHoldingValue.asCurrencyWith6Decimal())
                .bold()
            Text((coinModel.currentHoldings?.asStringNumber())!)
        }
        .foregroundColor(Color.theme.accent)
    }

    private var rightSection: some View {
        VStack(alignment: .trailing) {
            Text(coinModel.currentPrice.asCurrencyWith6Decimal())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coinModel.priceChangePercentage24h.asPercent())
                .foregroundColor(
                    coinModel.priceChangePercentage24h >= 0 ? Color.theme.greenColor : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

struct CoinImageView: View {
    let url: URL?
    @State private var image: UIImage? = nil
    @State private var isLoading = false
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
                    .onAppear(perform: loadImage)
            }
        }
    }
    
    private func loadImage() {
        guard !isLoading, let url = url else { return }
        if let cachedImage = CoinRowView.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        isLoading = true
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url), let loadedImage = UIImage(data: data) {
                CoinRowView.imageCache.setObject(loadedImage, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.image = loadedImage
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}
