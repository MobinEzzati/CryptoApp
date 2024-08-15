//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 8/8/24.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading , spacing: 0) {
                    SearchBarView(searchText: $vm.searchedText)
                     
                    coinLogoList
                    if selectedCoin != nil {
         
                        
                        portfolioInputSecion
                    }
          
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(id: "closeButton", placement: .topBarLeading) {
                    XmarkButton()
                }
                
                
                ToolbarItem(id: "save", placement: .topBarTrailing) {
                    trailingNavBar
                }
                
            }
            .onChange(of: vm.searchedText) { value in
                if value == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

// Preview
#Preview {
    PortfolioView()
        .environmentObject(HomeViewModel.homeVM)
}


extension PortfolioView {
    private var trailingNavBar: some View {
        HStack(spacing: 10) {
        
                // Background checkmark image
                Image(systemName: "checkmark")
                    .opacity(showCheckMark ? 1.0 : 0.0)
                    .offset(x: -10) // Adjust the offset if needed to better align the checkmark

                // Foreground text
                Button {
                    saveButton()
                } label: {
                    Text("save".uppercased())
                }
                .opacity(
                    (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
                )
            
        }
    }
    
    private var portfolioInputSecion : some View  {
        VStack(spacing: 20) {
            HStack {
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimal() ?? "")
                
            }
            Divider()
            HStack {
                Text("Amount in your portfolio ")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .animation(.easeInOut, value: quantityText)
                
            }
            
            Divider()
            HStack {
                Text("Current Value :")
                Spacer()
                Text(getCurrentValue().asCurrencyWith6Decimal())
                
            }
        }
        .animation(.none)
    }
    
    private var coinLogoList: some View {
        
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHStack(content: {
                ForEach(vm.searchedText.isEmpty ? vm.portfolioCoins : vm.alltcoins){ coin in
                     
                    CoinLogoView(coinModel: coin)
                        .frame(width: 75)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                               
                                updateSelectedCoin(coin: coin)
                                
                               
                                
                            }
                        }
                        .padding(3)
                        .background(
                         
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ?
                                        Color.theme.greenColor: Color.clear
                                        ,
                                        lineWidth:  1)
                        
                        )
                        
                       
                }
                .frame(height: 110)
                .padding(.leading)
            })
            }
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
       if  let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings {
           quantityText = "\(amount)"
       }else {
           quantityText = ""

       }
        
    }
    
    private func getCurrentValue() -> Double {
        
        
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButton(){
        
        guard let coin = selectedCoin,
              let amount = Double(quantityText)
        else {
            return
        }
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation {
            showCheckMark = true
            removeSelectedCoin()
        }
        UIApplication.shared.endEditing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeInOut) {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin () {
        selectedCoin = nil
        vm.searchedText = ""
    }
    

    
}
