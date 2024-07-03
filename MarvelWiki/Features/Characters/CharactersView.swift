//
//  CharactersView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct CharactersView: View {
    var body: some View {
        NavigationView {
            VStack{
                MarvelWikiSearchBar()
                    .padding(.top,0)
                Spacer()
                
               
               
            }
            
            .frame(maxWidth: .infinity)
            .background(Color("mBackground"))
        }
    }
}

#Preview {
    CharactersView()
}
