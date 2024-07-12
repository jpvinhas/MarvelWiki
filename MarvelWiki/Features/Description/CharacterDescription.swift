//
//  CharacterDescription.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 11/07/24.
//

import SwiftUI

struct CharacterDescription: View {
    
    @Environment(\.presentationMode) private var presentationMode
    //@StateObject private var comicsViewModel: ComicsViewModel = ComicsViewModel()
    @State var character: Character?
   
    var body: some View {
        NavigationStack{
           
         
            if character != nil{
                VStack{
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack{
                                Image(systemName: "arrow.backward.circle")
                                    .foregroundColor(Color("mClearGray"))
                                    .padding(.leading, 2)
                                    .font(.largeTitle)
                            }.padding()
                        })
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            HStack{
                                Image(systemName: "heart")
                                    .foregroundColor(Color("mClearGray"))
                                    .padding(.leading, 2)
                                    .font(.largeTitle)
                            }.padding()
                        })
                    }
                    if let urlImage = character?.thumbnail.path {
                        AsyncImage(url: URL(string:  (urlImage) + "." + (character?.thumbnail.ext ?? "jpg") )){ image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(color: .gray, radius: 10)
                                .frame(maxWidth: 160)
                                
                        }placeholder: {
                            ProgressView()
                        }
                        .padding(.top, -30)
                    }else{
                        ProgressView()
                    }
                    
                    Text(character?.name ?? "")
                        .foregroundStyle(Color(.white))
                        .font(.custom("BentonSans Comp Black", size: 20))
                        .padding(5)
                    HStack{
                        VStack{
                            Text("Writer")
                                .foregroundStyle(Color(.white))
                                .font(.custom("BentonSans Comp Black", size: 20))
                            Text("Writer")
                                .foregroundStyle(Color(.white))
                                
                        }.padding()
                        Spacer()
                        VStack{
                            Text("Penciller")
                                .foregroundStyle(Color(.white))
                                .font(.custom("BentonSans Comp Black", size: 20))
                            Text("Penciller")
                                .foregroundStyle(Color(.white))
                               
                        }.padding()
                        
                    }
                    Text(character?.description ?? "")
                        .foregroundStyle(Color(.white))
                        .font(.system(size: 14))
                        .padding(.horizontal)
                    Text("Comics")
                        .foregroundStyle(Color(.white))
                        .font(.custom("BentonSans Comp Black", size: 20))
                        .padding()

                }
                .background(Color("mBackground"))
               
            }else{
                ProgressView()
            }
        }.navigationBarBackButtonHidden(true)
    }
    
   
}

struct CharacterDescription_Previews: PreviewProvider {
    static var previews: some View {
        let character: Character = Character(id: 1009327, name: "Jean Grey",
            description: "A SYMBIOTIC FREE-FOR-ALL! Freshly united and teamed up, VENOM and TOXIN fight like hell to save one of the Marvel Universe's greatest heroes from the darkness within her.",
            thumbnail: Character.Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/f/d0/528d3412090b4", 
                                           ext: "jpg"), resourceURI: "", modified: Date.now, comics: Character.Comics(available: 0, collectionURI: "", items: [], returned: 0), urls: [])
        CharacterDescription(character: character)
    }
}
