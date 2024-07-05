//
//  ComicsView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct ComicsView: View {
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36)
    ]
    
    @EnvironmentObject var comicsViewModel: ComicsViewModel
    
    var ext = "jpg"
    var size = "portrait_medium"
    
    var body: some View {
        VStack {
            MarvelWikiSearchBar()
                .padding(.top,0)
            CarroselView()
                .padding(.top)
           ComicsList()
        }
    }
}

#Preview {
    ComicsView()
        .environmentObject(ComicsViewModel())
        .background(Color("mBackground"))
}
