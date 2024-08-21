//
//  LoadingCharactersView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 21/08/24.
//

import SwiftUI

struct LoadingCharactersView: View {
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<9, id: \.self) { card in
                    LoadingComicBox()
                }
            }
            .padding(.top, 10)
            .padding(.leading, 22)
            .padding(.trailing, 22)
        }
    }
}

#Preview {
    LoadingCharactersView()
        .environmentObject(CharactersViewModel.shared)
        .background(Color("mBackground"))
}
