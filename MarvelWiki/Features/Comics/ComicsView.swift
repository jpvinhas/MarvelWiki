//
//  ComicsView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct ComicsView: View {
    
    @StateObject var comicsViewModel = ComicsViewModel()
    var ext = "jpg"
    var size = "portrait_medium"
    
    var body: some View {
        VStack{
            Text("ComicsView")
                .foregroundStyle(Color("mClearGray"))
            
            if comicsViewModel.comics != nil {
                List(comicsViewModel.comics ?? []) { comic in
                    HStack{
                        if let url = URL(string: "\(comic.thumbnail.path)/\(size).\(ext)") {
                            AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 150)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 100, height: 150, alignment: .center)
                                }
                        }
                        Text("\(comic.title ?? "")")
                            .foregroundStyle(Color.black)
                    }
                }
                .background(Color.clear)
                
            }else {
                ProgressView("Loading...")
                .onAppear {
                    comicsViewModel.loadComics()
                }
                .navigationTitle("Loading")
            }
        }
    }
}

#Preview {
    ComicsView()
}
