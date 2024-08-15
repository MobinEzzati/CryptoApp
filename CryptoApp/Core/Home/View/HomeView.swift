//
//  HomeView.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/2/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false

    @EnvironmentObject private var vm : HomeViewModel
    var body: some View {
        maineView
    }
}

#Preview {
    NavigationStack {
        HomeView().toolbar(.hidden)
        
    }
    .environmentObject(HomeViewModel())
}



extension HomeView {
    
    private var maineView : some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            VStack() {
                
                homeHeader
                HomeStatView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchedText)
                columnTitles
               
                if !showPortfolio {
                  alltcoinList
                        .transition(.move(edge: .leading))
                    
                }
                if showPortfolio {
                    portfolioCoinList
                        .transition(.move(edge: .trailing))
                }

                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                
            }
        }
    }
    private var homeHeader: some View {
        HStack() {
            CircleButtonView(iconName: showPortfolio ? "plus":"info")
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleAnimaitonView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio":"Live Prices" )
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()

            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }.padding(.horizontal)
        
    }
    
    
    private var alltcoinList: some View {
        List {
            


            ForEach(vm.alltcoins){ (returnCoin) in
                
                CoinRowView(coinModel: returnCoin, showHoldingColumn: false)
                    .listRowInsets(.init(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: 0))

            }
            }
        
        .refreshable {
            
                vm.reloadData()
            
        } 
        
        
        
            .scrollContentBackground(.hidden) // Remove the default background
            .listStyle(.plain)
        
        
            

    }
    
    
    private var portfolioCoinList: some View {
        List {
            
            ForEach(vm.portfolioCoins){ coin in
                
                CoinRowView(coinModel: coin, showHoldingColumn: true)
                    .listRowInsets(.init(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: 0))

            }
            }
            .scrollContentBackground(.hidden) // Remove the default background
            .listStyle(.plain)
            
            

    }
    
    private var columnTitles: some View {
        
        HStack {
            HStack(spacing: 5){
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed ) ? 1.0:0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 :180))
            }.onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank

                }

            }
            
            Spacer()
            if showPortfolio {
                HStack(spacing: 5){
                    Text("Holding")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingReversed ) ? 1.0:0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 180 :0))


                }.onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingReversed : .holdings

                    }

                }
            }
            
            HStack(spacing: 5){
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed ) ? 1.0:0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 :180))
            }.frame(width: UIScreen.main.bounds.width / 2.5, alignment: .trailing)
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .price ? .priceReversed : .price

                    }

                }
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
