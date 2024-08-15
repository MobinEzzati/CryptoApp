//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/19/24.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticModel
    var body: some View {
        VStack(alignment: .leading, spacing: 3){
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                                    
                                    
                Text(stat.percentageChange?.asPercent() ?? "0")
            }
            .foregroundStyle ((stat.percentageChange ?? 0) >= 0 ? Color.green : Color.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

#Preview {

    Group {
        StatisticView(stat: StatisticModel.stat1)
        StatisticView(stat: StatisticModel.stat2)
        StatisticView(stat: StatisticModel.stat3)
    }

}
