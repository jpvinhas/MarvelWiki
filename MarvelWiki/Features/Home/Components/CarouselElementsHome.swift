//
//  CarouselElementsHome.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 05/07/24.
//

import Foundation
import SwiftUI

struct CarouselElementsHome: View {
    
    var primaryLink: PrimaryLink = PrimaryLink(link: "/erro", title: "Erro", content:[])
    var withBaseUrl: Bool
    var withTitles: Bool
    //@StateObject private var comicsViewModel: ComicsViewModel = ComicsViewModel()
    //@State var idComic: Int = 115440
    private var baseURL = "https://cdn.marvel.com/content/1x/"
    
    init(primaryLink: PrimaryLink, withBaseUrl: Bool, withTitles: Bool) {
        self.primaryLink = primaryLink
        self.withBaseUrl = withBaseUrl
        self.withTitles = withTitles
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(primaryLink.title)
                .font(.custom("BentonSans Comp Black", size: 24))
                .padding(.top, 15)
                .padding(.leading, 30)
                .foregroundStyle(Color(.white))
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing: 0){
                    ForEach(0..<primaryLink.content.count/3, id: \.self){ index in
                        HStack{
                            ForEach(0..<3) { subIndex in
                                let card = primaryLink.content[index * 3 + subIndex]
                            
                                NavigationLink(destination: CharacterDescription( character: nil)) {
                                    
                                    VStack{
                                        if let url = URL(string: (withBaseUrl ? baseURL : "") + card.image.filename) {
                                            URLImage(url)
                                        }
                                        
                                        if withTitles{
                                            Text(card.headline)
                                                .font(.custom("BentonSans Comp Black", size: 16))
                                                .frame(width: 100)
                                                .padding(.bottom)
                                                .foregroundStyle(Color(.white))
                                        }
                                    }
                                }.task{
                                     //self.comicsViewModel.idComic = self.idComic
                                }
                            }
                        }
                        .containerRelativeFrame(.horizontal)
                            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.6)
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                            }
                        
                    }
                }.scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            //.frame(height: 190)
        }
    }
}

