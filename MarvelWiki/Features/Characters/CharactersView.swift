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
                Spacer()
               
                //            Text("CharactersView")
                //                .foregroundStyle(Color("mClearGray"))
                //
            }
        }
    }
}

#Preview {
    CharactersView()
}
