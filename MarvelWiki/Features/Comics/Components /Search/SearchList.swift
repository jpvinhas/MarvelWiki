//
//  SearchList.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 05/07/24.
//

import SwiftUI

struct SearchList: View {
    @ObservedObject var searchModel: SearchViewModel

    var body: some View {
        VStack(alignment: .leading){
            if searchModel.searchComics?.count != 0 {
                ScrollView(.vertical, showsIndicators: false) {
                    Text("\(searchModel.total) results:")
                        .font(.custom("BentonSans Comp Black", size: 16))
                        .foregroundStyle(Color("mClearGray"))
                    LazyVGrid(columns: searchModel.columns, spacing: 20) {
                        ForEach(filteredComics()) { comic in
                            ComicBox(comic: comic)
                        }
                    }
                    .padding(.top,5)
                    .padding(.horizontal,30)
                    
                    if searchModel.isLoading {
                        ProgressView("Loading...")
                            .foregroundStyle(Color("mClearGray"))
                            .frame(minWidth: UIScreen.main.bounds.width)
                    }else {
                        Button(action: {
                            searchModel.loadSearchComics()
                        }, label: {
                            HStack{
                                Text("Load More")
                                    .font(.custom("BentonSans Comp Black", size: 20))
                                Image(systemName: "arrow.down.circle")
                            }
                            .padding()
                            .background(Color("mRed"))
                            .cornerRadius(10)
                        })
                    }
                }
            }else {
                Spacer()
                if searchModel.isLoading {
                    ProgressView("Loading...")
                        .foregroundStyle(Color("mClearGray"))
                        .frame(minWidth: UIScreen.main.bounds.width)
                }else if searchModel.searchText.count == 0 {
                    Text("Search")
                        .foregroundStyle(Color("mClearGray"))
                        .frame(minWidth: UIScreen.main.bounds.width)
                }else if searchModel.total == -1 {
                    Text("Not Found")
                        .foregroundStyle(Color("mClearGray"))
                        .frame(minWidth: UIScreen.main.bounds.width)
                }else if searchModel.searchComics?.count == 0 {
                    Text("Click on Search")
                        .foregroundStyle(Color("mClearGray"))
                        .frame(minWidth: UIScreen.main.bounds.width)
                }
                Spacer()
            }
        }.padding(.top,5)
            .onDisappear{
                searchModel.searchOffset = 0
            }
    }
    private func filteredComics() -> [Comic] {
        let def = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
        return searchModel.searchComics?.filter { comic in
            return comic.thumbnail.path != def
        } ?? []
    }
}
