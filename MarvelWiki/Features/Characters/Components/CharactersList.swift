//
//  CharactersList.swift
//  MarvelWiki
//
//  Created by Ricardo Silva Vale on 11/07/24.
//

import SwiftUI

struct CharactersList: View {
   
    @EnvironmentObject var viewModel: CharactersViewModel

    var size = "portrait_medium"
   
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing: 20) {
                        ForEach(viewModel.getFilteredCharacters()) { character in
                            VStack {
                                CharacterBox(character: character)
                            }
                            .onAppear {
                                if character == viewModel.getFilteredCharacters().last {
                                    viewModel.fetchMoreCharacters()
                                }
                            }
                        }
                    }
                    .padding(.top, 10)
                    .padding(.leading, 22)
                    .padding(.trailing, 22)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color("mBackground"))
        }
    }
}
