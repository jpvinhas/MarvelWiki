//
//  ComicsView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct ComicsView: View {
    
    @EnvironmentObject var comicsViewModel: ComicsViewModel
    
    var body: some View {
        VStack {
            MarvelWikiSearchBar(searchText: $comicsViewModel.searchText, isSearching: $comicsViewModel.isSearchingComic, search: $comicsViewModel.search)
                .padding(.top,0)
            if comicsViewModel.isSearchingComic {
                SearchList()
                Spacer()
            }else{
                CarroselView()
                    .padding(.top)
                ComicsList()
            }
        }
    }
}

#Preview {
    ComicsView()
        .environmentObject(ComicsViewModel())
        .background(Color("mBackground"))
}
