//
//  CharactersList.swift
//  MarvelWiki
//
//  Created by Ricardo Silva Vale on 11/07/24.
//

import SwiftUI

struct CharactersList: View {
    @EnvironmentObject private var viewModel: CharactersViewModel
    
    var size = "portrait_medium"
    // private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing: 20) {
                        ForEach(viewModel.getFilteredCharacters()) { character in
                            VStack {
                                if let url = URL(string: "\(character.thumbnail.path)/\(size).\(character.thumbnail.ext)") {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 150)
                                            .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 100, height: 150)
                                            .cornerRadius(10)
                                    }
                                    Text(character.name)
                                        .font(Font.custom("BentonSans Comp Black", size: 14))
                                        .multilineTextAlignment(.center)
                                        .frame(width: 100, height: 14)
                                        .foregroundColor(.white)
                                        .padding(.top, 3)
                                }
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
            .onAppear {
                viewModel.fetchCharacters()
            }
            .frame(maxWidth: .infinity)
            .background(Color("mBackground"))
        }
    }
    
}

#Preview {
    CharactersList()
        .environmentObject(CharactersViewModel())
}
