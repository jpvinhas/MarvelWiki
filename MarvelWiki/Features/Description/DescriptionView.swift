//
//  DescriptionView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct DescriptionView: View {
    var body: some View {
        HStack{
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack{
                    Image(systemName: "arrow.backward.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.leading, 2)
                        .font(.largeTitle)
                }
            })
            AsyncImage(url:  URL(string:  "https://cdn.marvel.com/u/prod/marvel/i/mg/3/50/59132c67b2c90/clean.jpg")){ image in
                image.image?
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack{
                    Image(systemName: "heart.fill")
                        .foregroundColor(.gray)
                        .padding(.leading, 2)
                        .font(.largeTitle)
                }
            })
        }
        Text("Description View")
            .foregroundStyle(Color("mClearGray"))

    }
}

#Preview {
    DescriptionView()
}
