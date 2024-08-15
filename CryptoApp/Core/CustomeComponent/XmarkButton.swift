//
//  XmarkButton.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 8/8/24.
//

import SwiftUI

struct XmarkButton: View {
    @Environment(\.dismiss) var presentationMode

    var body: some View {

        Button(action: {

            presentationMode.callAsFunction()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })


    }
}

#Preview {
    XmarkButton()
}
