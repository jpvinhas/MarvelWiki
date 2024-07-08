//
//  ComicsList.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 03/07/24.
//

import SwiftUI

struct ComicsList: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36)
    ]
    
    @Binding var comics: [Comic]?
    var def = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"

    
    var body: some View {
        VStack(alignment: .leading){
            if comics != nil {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(comics ?? []) { comic in
                            if comic.thumbnail.path != def {
                                ComicBox(comic: comic)
                                    .frame(maxWidth: 100)
                            }
                        }
                    }
                    .padding(.top,5)
                    .padding(.horizontal,30)
                }
            }else {
                Spacer()
                ProgressView("Loading...")
                    .foregroundStyle(Color("mClearGray"))
                    .frame(minWidth: 390)
                Spacer()
            }
        }
    }
}
