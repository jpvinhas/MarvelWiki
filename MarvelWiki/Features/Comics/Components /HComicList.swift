//
//  HComicList.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 04/07/24.
//

import SwiftUI

struct HComicList: View {
    private let rows: [GridItem] = [
        GridItem(.flexible(), spacing: 36),
    ]
    
    @ObservedObject var comicsViewModel: ComicsViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Comics")
                    .font(.custom("BentonSans Comp Black", size: 26))
                    .foregroundStyle(Color.white)
                    .padding(.leading,24)
                Button(action: {print("see all")}, label: {Text("See All")})
            }
            if comicsViewModel.comics != nil {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center) {
                        ForEach(comicsViewModel.comics ?? []) { comic in
                            ComicBox(comic: comic)
                                .frame(height: 200)
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
