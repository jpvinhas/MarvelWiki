//
//  ComicsList.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 03/07/24.
//

import SwiftUI

struct ComicsList: View {
    
    @EnvironmentObject var comicsViewModel: ComicsViewModel

    var body: some View {
        VStack(alignment: .leading){
            Text("Comics")
                .font(.custom("BentonSans Comp Black", size: 26))
                .foregroundStyle(Color.white)
                .padding(.leading,24)
            if comicsViewModel.comics != nil {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: comicsViewModel.columns, spacing: 20) {
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
                    .frame(minWidth: 390)
                Spacer()
            }
        }
    }
}
