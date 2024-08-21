//
//  FavoritesView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 21/08/24.
//

import SwiftUI

struct FavoritesView: View {
    
    @State private var viewModel = FavoritesViewModel.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.favoriteComics.isEmpty{
                    ScrollView {
                        LazyVGrid(columns: viewModel.columns, spacing: 20) {
                            ForEach(viewModel.favoriteComics) { comic in
                                ComicBox(comic: comic)
                            }
                        }
                        .padding(.top, 10)
                        .padding(.horizontal,20)
                    }.background(Color.clear)
                }else{
                    Image("noFavoriteComic")
                        .padding(.trailing)
                    Text("Nenhum Quadrinho Favorito!")
                        .font(.custom("BentonSans Comp Black", size: 22))
                        .foregroundStyle(Color.white)
                        .padding(.bottom)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("mBackground"))

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("mBackground"))
        
    }
}

#Preview {
    FavoritesView()
}

