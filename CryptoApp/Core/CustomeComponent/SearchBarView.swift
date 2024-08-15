//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 7/17/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        
            
        
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondaryText: Color.theme.accent
                
                )
            
       
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .overlay(
                
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
                
               
            
              
                
        }
        .font(.headline)
        .padding()
        .background(
        
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.theme.background)
            .shadow(color: Color.theme.accent.opacity(0.15), radius: 10,x: 0,y: 0)
        )
        .padding()
        
    }
}

#Preview {
    Group {
        
        
        SearchBarView(searchText: .constant("")).previewLayout(.sizeThatFits).preferredColorScheme(.light)
    }
}
