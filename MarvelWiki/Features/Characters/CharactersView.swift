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
    
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack{
                MarvelWikiSearchBar()
                    .padding(.top,0)
                Spacer()
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 20){
                        ForEach(viewModel.characters){ character in
                            VStack{
                                if let url = URL(string: "\(character.thumbnail.path)/\(size).\(ext)"){
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
                            }
                        }
                    }
                        .padding(.leading, 22)
                        .padding(.trailing, 22)
                }
            }.onAppear{
                print(viewModel.fetchCharacters)
            }
               
        }

        .frame(maxWidth: .infinity)
        .background(Color("mBackground"))
    }
}
  
  


#Preview {
    CharactersView()
    
}
