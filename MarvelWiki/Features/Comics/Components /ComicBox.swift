//
//  ComicBox.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 03/07/24.
//

import SwiftUI

struct ComicBox: View {
    
    var comic: Comic
    private var ext = "jpg"
    private var size = "portrait_medium"
    
    init(comic: Comic) {
        self.comic = comic
    }
    
    var body: some View {
        VStack{
            if let url = URL(string: "\(comic.thumbnail.path)/\(size).\(ext)") {
                AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 150).cornerRadius(10)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 150, alignment: .center)
                }
            }
            Text("\( formatTitle(title: comic.title ?? ""))")
                .font(.custom("BentonSans Comp Black", size: 14))
                .foregroundStyle(Color.white)
        }
    }
    func formatTitle(title: String) -> String {
        let components = title.components(separatedBy: " (")

        let formatedtitle = components[0].trimmingCharacters(in: .whitespaces)

        //let year = components[1].components(separatedBy: ")")[0]
        
        return formatedtitle
    }
}
