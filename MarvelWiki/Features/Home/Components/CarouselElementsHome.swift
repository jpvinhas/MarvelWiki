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
    private var baseURL = "https://cdn.marvel.com/content/1x/"
    
    init(primaryLink: PrimaryLink, withBaseUrl: Bool, withTitles: Bool) {
        self.primaryLink = primaryLink
        self.withBaseUrl = withBaseUrl
        self.withTitles = withTitles
    }
    
    var body: some View {
        VStack{
            Text(primaryLink.title)
                .font(.custom("BentonSans Comp Black", size: 24))
                .padding(.top)
                .foregroundStyle(Color(.white))
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing: 0){
                    ForEach(0..<primaryLink.content.count/3, id: \.self){ index in
                        HStack{
                            ForEach(0..<3) { subIndex in
                                let card = primaryLink.content[index * 3 + subIndex]
                                
                                VStack{
                                    if let url = URL(string: (withBaseUrl ? baseURL : "") + card.image.filename) {
                                        
                                        AsyncImage(url: url){ image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                .shadow(color: .gray, radius: 3)
                                                .padding(4)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }else{
                                        
                                        ProgressView("Loading...")
                                            .navigationTitle("Loading")
                                        
                                    }
                                    
                                    Text(withTitles ? card.headline : "")
                                        .font(.custom("BentonSans Comp Black", size: 16))
                                        .frame(width: 100)
                                        .padding(.bottom)
                                        .foregroundStyle(Color(.white))
                                    
                                }
                            }
                        }
                        .padding(.top)
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

