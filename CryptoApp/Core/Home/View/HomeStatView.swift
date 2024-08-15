//
//  HomeStatView.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/19/24.
//

import SwiftUI

struct HomeStatView: View {

    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    var body: some View {
        HStack {
            ForEach(vm.statistics , id: \.self) { statistics in
                
                
                StatisticView(stat: statistics).frame(width: UIScreen.main.bounds.width / 3
                )
            }

        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)

    }
}

#Preview {
    HomeStatView(showPortfolio: .constant(false))
        .environmentObject(HomeViewModel.homeVM)
}
