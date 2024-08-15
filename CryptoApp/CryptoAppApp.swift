//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 5/29/24.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    @State private var showSplashScreen = true

    @StateObject var vm = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]

    }
    var body: some Scene {
        
        WindowGroup {
            NavigationStack {
                
                if showSplashScreen {
                    SplashScreen()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                                    withAnimation {
                                        self.showSplashScreen = false
                                    }
                                }
                            }
                    
                    
                }else {
                    HomeView().toolbar(.hidden)
                }
                
                
                
                
            }.environmentObject(vm)
            
        }
    }
}
