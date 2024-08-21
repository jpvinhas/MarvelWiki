//
//  SearchCharacters.swift
//  MarvelWiki
//
//  Created by Ricardo Silva Vale on 11/07/24.
//

import SwiftUI

struct SearchCharacters: View {
    
    @EnvironmentObject var charactersViewModel: CharactersViewModel

    var body: some View {
        VStack(alignment: .leading){
            if !charactersViewModel.searchCharacter.isEmpty {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: charactersViewModel.columns, spacing: 20) {
                        ForEach(charactersViewModel.searchCharacter) { character in
                            CharacterBox(character: character)
                        }
                    }
                }
            }else {
                Spacer()
                if charactersViewModel.searchText.isEmpty {
                    Text("Search")
                        .foregroundStyle(Color("mClearGray"))
                        .frame(minWidth: UIScreen.main.bounds.width)
                }else if charactersViewModel.searchCharacter.isEmpty {
                    Text("Not Found")
                        .foregroundStyle(Color("mClearGray"))
                        .frame(minWidth: UIScreen.main.bounds.width)
                }else {
                    ProgressView("Loading...")
                        .foregroundStyle(Color("mClearGray"))
                        .frame(minWidth: UIScreen.main.bounds.width)
                }
                Spacer()
            }
        }   .padding(.top, 10)
            .padding(.leading, 22)
            .padding(.trailing, 22)
            .onDisappear{
                print("apagando array")
                charactersViewModel.searchCharacter.removeAll()
            }
    }
}


