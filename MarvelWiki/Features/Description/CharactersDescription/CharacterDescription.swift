//
//  CharacterDescription.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 11/07/24.
//

import SwiftUI

struct CharacterDescription: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @State var isFavorite: Bool = false
    var character: Character?
    
    @ObservedObject var descriptionViewModel: CharactersDescriptionViewModel
   
    init(character: Character){
        self.character = character
        self.descriptionViewModel = CharactersDescriptionViewModel(character: character)
    }
    
    var body: some View {
        NavigationStack{
            if character != nil{
                ScrollView{
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
                            
                        }
                        if let urlImage = character?.thumbnail.path {
                            AsyncImage(url: URL(string:  (urlImage) + "/portrait_fantastic." + (character?.thumbnail.ext ?? "jpg") )){ image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 168, height: 252)
                                    .cornerRadius(10)
                                    .shadow(color: .gray, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 168, height: 252, alignment: .center)
                            }
                            .padding(.top, -30)
                        }else{
                            ProgressView()
                        }
                        
                        Text(character?.name ?? "")
                            .foregroundStyle(Color(.white))
                            .font(.custom("BentonSans Comp Black", size: 20))
                            .padding(5)
                        VStack(alignment: .leading){
                            if character?.description.count != 0{
                                Text("Description")
                                    .foregroundStyle(Color(.white))
                                    .font(.custom("BentonSans Comp Black", size: 26))
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 30)
                              
                                Text(character?.description ?? "")
                                    .foregroundStyle(Color(.white))
                                    .padding(.horizontal, 30)
                                    .font(.custom("Poppins-Light", size: 14))
                            }
                           
                            if descriptionViewModel.available != 0{
                                HComicsList(viewModel: descriptionViewModel)
                            }
                        }
                    }
                  
                   
                } .background(Color("mBackground"))
                
               
            }else{
                ProgressView()
            }
        }.navigationBarBackButtonHidden(true)
            .onAppear{
            descriptionViewModel.getComicsByCharacter()
        }
    }
    
    func formatYear(title: String) -> String {
        let components = title.components(separatedBy: "-")

        let formatedyear = components[0].trimmingCharacters(in: .whitespaces)

        return formatedyear
    }
   
}

struct CharacterDescription_Previews: PreviewProvider {
    static var previews: some View {
        let character: Character = Character(id: 1009327, name: "Jean Grey",
            description: "A SYMBIOTIC FREE-FOR-ALL! Freshly united and teamed up, VENOM and TOXIN fight like hell to save one of the Marvel Universe's greatest heroes from the darkness within her.",
            thumbnail: Character.Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/f/d0/528d3412090b4", 
                                           ext: "jpg"), resourceURI: "", modified: "",comics: Character.Comics(available: 0, collectionURI: "", items: [], returned: 0), urls: [])
        CharacterDescription(character: character)
    }
}
