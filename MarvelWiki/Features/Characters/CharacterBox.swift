//
//  CharacterBox.swift
//  MarvelWiki
//
//  Created by Ricardo Silva Vale on 11/07/24.
//

import SwiftUI

struct CharacterBox: View {
    @StateObject private var viewModel = CharactersViewModel()
    var character: Character
    var size = "portrait_medium"
    var notLoad = [
        "http://i.annihil.us/u/prod/marvel/i/mg/f/60/4c002e0305708",
        "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
    ]
    
    init(character: Character) {
        self.character = character
    }
    var body: some View {
        VStack {
            if let url = URL(string: "\(character.thumbnail.path)/\(size).\(character.thumbnail.ext)") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
                }
                Text(character.name)
                    .font(Font.custom("BentonSans Comp Black", size: 14))
                    .multilineTextAlignment(.center)
                    .frame(width: 100, height: 14)
                    .foregroundColor(.white)
                    .padding(.top, 3)
            }
        }
        
    }
}

