//
//  CarouselHome.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 05/07/24.
//

import Foundation
import SwiftUI


struct CarouselHome: View{
    @State private var scrollID: Int?
    var primaryLink: PrimaryLink = PrimaryLink(link: "/erro", title: "Erro", content:[])
    
    var body: some View{
        VStack{
        
            Text(primaryLink.title)
                .font(.custom("BentonSans Comp Black", size: 28))
                .padding(.top)
                .foregroundStyle(Color(.white))
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing: 0){
                    ForEach(1..<primaryLink.content.count, id: \.self){ index in
                        
                        HStack{
                            
                            let card1 = primaryLink.content[index]
                            
                            VStack{
                                
                                if let url = URL(string: "https://cdn.marvel.com/content/1x/" + card1.image.filename) {
                                    AsyncImage(url: url){ image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 340)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .shadow(color: .gray, radius: 10)
                                            .padding(4)
                                    } placeholder: {
                                        ProgressView()
                                    }.onAppear()
                                }else{
                                    ProgressView("Loading...")
                                        .navigationTitle("Loading")
                                }
                            }
                            
                        }.containerRelativeFrame(.horizontal)
                            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.6)
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                            }
                    }
                }.scrollTargetLayout()
            }
            .scrollPosition(id: $scrollID)
            .scrollTargetBehavior(.paging)
            .frame(height: 220)
            IndicatorView(imageCount: primaryLink.content.count, scrollID: $scrollID)
        }
    
    }
}
