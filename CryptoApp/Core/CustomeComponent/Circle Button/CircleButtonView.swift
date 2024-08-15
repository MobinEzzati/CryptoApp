//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/3/24.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName:String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .frame(width: 50,height:50)
            .foregroundStyle(.blue)
            .background(
            
                Circle().foregroundStyle(Color.theme.background)
            )
            .shadow(color: Color.theme.accent, radius: 10, x: 0, y: 5)
        
    }
}

#Preview {
    
    Group {
        
        CircleButtonView(iconName: "plus")
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            
        CircleButtonView(iconName:"info")
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
    }
    

}

