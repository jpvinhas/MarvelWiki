//
//  ComicsList.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 03/07/24.
//

import SwiftUI

struct ComicsList<T: ComicsModel>: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    @ObservedObject var viewModel: T
    
    var body: some View {
        VStack(alignment: .leading){
            if viewModel.comics.count != 0 {
                ScrollView(.vertical, showsIndicators: false) {
                    Text("\(viewModel.available) results:")
                        .font(.custom("BentonSans Comp Black", size: 16))
                        .foregroundStyle(Color("mClearGray"))
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredComics()) { comic in
                            ComicBox(comic: comic)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.top,5)
                    .padding(.horizontal,30)
                    
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .foregroundStyle(Color("mClearGray"))
                            .frame(minWidth: UIScreen.main.bounds.width)
                    }else {
                        Button(action: {
                            viewModel.loadComics()
                        }, label: {
                            HStack(alignment: .center){
                                Text("Load More")
                                    .font(.custom("BentonSans Comp Black", size: 20))
                                    .foregroundStyle(Color.white)
                                Image(systemName: "arrow.down.circle")
                                    .font(.system(size: 20,weight: .bold))
                                    .foregroundStyle(Color.white)
                            }
                            .padding()
                            .background(Color("mRed"))
                            .cornerRadius(10)
                        })
                    }
                }
            }else {
                Spacer()
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .foregroundStyle(Color("mClearGray"))
                        .frame(minWidth: UIScreen.main.bounds.width)
                }else if viewModel.available == -1 {
                    Text("Not Found")
                        .foregroundStyle(Color("mClearGray"))
                        .frame(minWidth: UIScreen.main.bounds.width)
                }else if viewModel.comics.count == 0 {
                    Text("Click on Search")
                        .foregroundStyle(Color("mClearGray"))
                        .frame(minWidth: UIScreen.main.bounds.width)
                }
                Spacer()
            }
        }
    }
    private func filteredComics() -> [Comic] {
        let def = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
        return viewModel.comics.filter { comic in
            return comic.thumbnail.path != def
        }
    }
}
