//
//  ComicsView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct ComicsView: View {
    
    @StateObject var searchModel = SearchViewModel()
    @StateObject var allComicsModel = ComicsViewModel.shared
    @StateObject var newComicsModel = NewComicsViewModel.shared
    
    var body: some View {
        NavigationStack{
            VStack {
                MarvelWikiSearchBar(searchText: $searchModel.searchText, isSearching: $searchModel.isSearchingComic, search: $searchModel.search)
                    .padding(.top,0)
                if searchModel.isSearchingComic {
                    ComicsList(viewModel: searchModel)
                    Spacer()
                }else{
                    ScrollView(.vertical,showsIndicators: false){
                        CarroselView()
                            .padding(.top)
                        HComicList<NewComicsViewModel>(title: "New Comics",viewModel: newComicsModel)
                        HComicList<ComicsViewModel>(title: "All Comics",viewModel: allComicsModel)
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
