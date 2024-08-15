//
//  UiApplication.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/17/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        
        sendAction(#selector(UIResponder.resignFirstResponder), to:nil , from: nil, for: nil)
    }
}



struct Popup<PopupContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let popupContent: () -> PopupContent

    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isPresented ? 3 : 0)
            
            if isPresented {
                popupContent()
                    .frame(maxWidth: 300)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 20)
                    .transition(.scale)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut, value: isPresented)
    }
}

extension View {
    func popup<PopupContent: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> PopupContent) -> some View {
        self.modifier(Popup(isPresented: isPresented, popupContent: content))
    }
}
