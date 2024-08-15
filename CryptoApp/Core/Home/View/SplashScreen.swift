//
//  SplashScreen.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/19/24.
//
import SwiftUI


struct SplashScreen: View {
    @State private var scale: CGFloat = 0.3
    @State private var opacity: Double = 0.0

    var body: some View {
        ZStack {
            Color.theme.background
                .edgesIgnoringSafeArea(.all) // To cover the entire screen
            
            VStack {
                Image("GS")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100) // Initial size
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeOut(duration: 1.0)) {
                            self.scale = 1.0
                            self.opacity = 1.0
                        }
                    }
                    
                
                Text("Gosuits.com")
                    .font(.custom("FancyFont", size: 30))
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.5).delay(0.5)) {
                            self.opacity = 1.0
                        }
                    }
            }
        }
    }
}
#Preview {
    SplashScreen()
}
