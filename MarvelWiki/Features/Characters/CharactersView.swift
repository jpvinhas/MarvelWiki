//
//  CharactersView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI


struct CharactersView: View {
    @StateObject private var viewModel = CharactersViewModel()
   
    var ext = "jpg"
    var size = "portrait_medium"
    var notload = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/portrait_medium.jpg"
    
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack{
                //MarvelWikiSearchBar()
                    //.padding(.top,0)
                Spacer()
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 20){
                        ForEach(viewModel.characters){ character in
                          
                            if let url = URL(string: "\(character.thumbnail.path)/\(size).\(ext)")
                            {
                                if url != URL(string: notload) {
                                    VStack{
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 150).cornerRadius(10)
                                                
                                            
                                            
                                            
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 100, height: 150, alignment: .center)
                                                .cornerRadius(10)
                                                .background()
                                        }.onAppear{
                                            print(url)
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
                        
                    }
                        .padding(.top, 10)
                        .padding(.leading, 22)
                        .padding(.trailing, 22)
                }
            }.onAppear{
                print(viewModel.fetchCharacters)
            }
            .frame(maxWidth: .infinity)
            .background(Color("mBackground"))
        }

    }
}
  
  


#Preview {
    CharactersView()
    
}
