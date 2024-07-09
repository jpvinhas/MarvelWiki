//
//  ComicDescription.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 08/07/24.
//

import Foundation
import SwiftUI

struct ComicDescription: View {
    
    @State var comic: Comic?
    @StateObject var comicsViewModel: ComicsViewModel = ComicsViewModel()
    @Binding var idComic: Int {
        didSet{
            comic = comicsViewModel.loadComicById(id: self.idComic) ?? nil
        }
    }
    
    var body: some View {
        NavigationStack{
           
            if comic != nil{
                VStack{
                    HStack{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            HStack{
                                Image(systemName: "arrow.backward.circle.fill")
                                    .foregroundColor(Color("mClearGray"))
                                    .padding(.leading, 2)
                                    .font(.largeTitle)
                            }.padding()
                        })
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            HStack{
                                Image(systemName: "heart.fill")
                                    .foregroundColor(Color("mClearGray"))
                                    .padding(.leading, 2)
                                    .font(.largeTitle)
                            }.padding()
                        })
                    }
                    AsyncImage(url: URL(string:  comicsViewModel.comicById?.thumbnail.path ?? "")){ image in
                        image.image?
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .gray, radius: 10)
                            .frame(maxWidth: 160)
                            
                    }.padding(.top, -30)
                    Text("Description View")
                        .foregroundStyle(Color("mClearGray"))
                }
                .background(Color("mBackground"))
                .onAppear{
                    print( idComic )
                }
                
            }else{
                ProgressView()
            }
        }
    }
}

struct ComicDescription_Previews: PreviewProvider {
    static var previews: some View {
        ComicDescription(idComic: .constant(13860))
    }
}
