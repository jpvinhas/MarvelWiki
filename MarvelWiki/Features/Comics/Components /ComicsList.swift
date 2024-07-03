//
//  ComicsList.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 03/07/24.
//

import SwiftUI

struct ComicsList: View {
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36)
    ]
    
    @ObservedObject var comicsViewModel: ComicsViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Quadrinhos")
                .font(.custom("BentonSans Comp Black", size: 24))
                .foregroundStyle(Color("mClearGray"))
                .padding(.leading,25)
            if comicsViewModel.comics != nil {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(comicsViewModel.comics ?? []) { comic in
                            ComicBox(comic: comic)
                        }
                    }
                    .padding(.top,5)
                    .padding(.horizontal,30)
                }
            }else {
                Spacer()
                ProgressView("Loading...")
                    .foregroundStyle(Color("mClearGray"))
                Spacer()
            }
        }
    }
}
