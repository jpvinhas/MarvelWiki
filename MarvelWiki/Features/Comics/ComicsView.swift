//
//  ComicsView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct ComicsView: View {
    
    @EnvironmentObject var comicsViewModel: ComicsViewModel
    @StateObject var searchModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack{
            VStack {
                MarvelWikiSearchBar(searchText: $searchModel.searchText, isSearching: $searchModel.isSearchingComic, search: $searchModel.search)
                    .padding(.top,0)
                if searchModel.isSearchingComic {
                    SearchList(searchModel: searchModel)
                    Spacer()
                }else{
                    ScrollView{
                        CarroselView()
                            .padding(.top)
                        HComicList(title: "New Comics",comics: comicsViewModel.newComics)
                        HComicList(title: "All Comics",comics: comicsViewModel.comics)
                    }
                }
            }.background(Color("mBackground"))
        }
    }
}

#Preview {
    ComicsView()
        .environmentObject(ComicsViewModel())
        .background(Color("mBackground"))
}
