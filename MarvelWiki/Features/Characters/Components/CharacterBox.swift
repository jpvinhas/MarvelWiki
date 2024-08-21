//
//  CharacterBox.swift
//  MarvelWiki
//
//  Created by Ricardo Silva Vale on 11/07/24.
//

import SwiftUI

struct CharacterBox: View {
    
    var character: Character
    var size = "portrait_medium"
    var notLoad = [
        "http://i.annihil.us/u/prod/marvel/i/mg/f/60/4c002e0305708",
        "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
    ]
    
    @State private var isImageLoaded = false
    @State private var isTextLoaded = false
    
    init(character: Character) {
        self.character = character
    }
    var body: some View {
        NavigationLink(destination: CharacterDescription(character: character)){
            VStack {
                if let url = URL(string: "\(character.thumbnail.path)/\(size).\(character.thumbnail.ext)") {
                    AsyncImage(url: url) { image in
                        switch image {
                        case .empty:
                            ShimmerEffectBox()
                                .frame(width: 100, height: 150)
                                .cornerRadius(10)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 150)
                                .cornerRadius(10)
                                .onAppear {
                                    isImageLoaded = true
                                }
                        case .failure:
                            Image(systemName: "xmark.octagon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 150)
                                .cornerRadius(10)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    ShimmerEffectBox()
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
                }
                
                if isImageLoaded {
                    Text(character.name)
                        .font(Font.custom("BentonSans Comp Black", size: 14))
                        .multilineTextAlignment(.center)
                        .frame(width: 100, height: 14)
                        .foregroundColor(.white)
                        .padding(.top, 3)
                        .onAppear {
                            isTextLoaded = true
                        }
                    
                } else {
                    ShimmerEffectBox()
                        .frame(width: 100, height: 14)
                        .cornerRadius(3)
                }
            }
        }
    }
}


