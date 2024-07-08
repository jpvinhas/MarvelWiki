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
    var title: String?
    var comics: [Comic]?
    var def = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(title ?? "Comics")
                    .font(.custom("BentonSans Comp Black", size: 26))
                    .foregroundStyle(Color.white)
                Spacer()
                Button(action: {
                    print("see all")
                }, label: {
                    Text("See All")
                        .font(.custom("BentonSans Comp Black", size: 15))
                        .foregroundStyle(Color.white)
                        .opacity(0.5)
                })
            }
            .padding()
            .padding(.horizontal,12)
            if comics != nil {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center) {
                        ForEach(comics ?? []) { comic in
                            if comic.thumbnail.path != def {
                                ComicBox(comic: comic)
                                    .frame(maxWidth: 100)
                            }
                        }
                    }
                    .padding(.horizontal,30)
                }.frame(minHeight: 0)
            }else {
                Spacer()
                ProgressView()
                    .foregroundStyle(Color("mClearGray"))
                    .frame(minWidth: 390,minHeight: 160)
                Spacer()
            }
        }
    }
}
