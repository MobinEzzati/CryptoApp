//
//  CircleAnimaitonView.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/3/24.
//

import SwiftUI

struct CircleAnimaitonView: View {
    @Binding  var animate : Bool
     
     var body: some View {
         ZStack {
             Circle()
                 .stroke(Color.theme.accent, lineWidth: 3)
                 .scaleEffect(animate ? 1.5 : 1.0)
                 .opacity(animate ? 0.0 : 1.0)
                 .animation(animate ? .easeOut(duration: 2.0) : .none)
                 
         }
      
         
       

     }
}

#Preview {
    CircleAnimaitonView(animate: .constant(false))
        .frame(width: 100,height: 100)
}
