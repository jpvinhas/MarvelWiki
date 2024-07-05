//
//  SearchList.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 05/07/24.
//

import SwiftUI

struct SearchList: View {
    @EnvironmentObject var comicsViewModel: ComicsViewModel

    var body: some View {
        VStack(alignment: .leading){
            if comicsViewModel.searchComics != nil && comicsViewModel.searchComics?.count != 0 {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: comicsViewModel.columns, spacing: 20) {
                        ForEach(comicsViewModel.searchComics ?? []) { comic in
                            ComicBox(comic: comic)
                        }
                    }
                    .padding(.top,5)
                    .padding(.horizontal,30)
                    Button(action: {
                        print("loadMore")
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
            }else {
                Spacer()
                if comicsViewModel.searchText.count == 0 {
                    Text("Search")
                        .foregroundStyle(Color("mClearGray"))
                        .frame(minWidth: UIScreen.main.bounds.width)
                }else if comicsViewModel.searchComics == nil {
                    Text("Click on Search")
                        .foregroundStyle(Color("mClearGray"))
                        .frame(minWidth: UIScreen.main.bounds.width)
                }else if comicsViewModel.searchComics?.count == 0 {
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
        }.padding(.top,5)
        .onDisappear{
            print("apagando array")
            comicsViewModel.searchComics?.removeAll()
        }
    }
}
