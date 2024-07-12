//
//  HomeDescription.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 11/07/24.
//

import SwiftUI

struct HomeDescription: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var newComicsModel = NewComicsViewModel()
    @State var card: CardHome
    @State private var isFavorite : Bool = false
    var withBaseUrl: Bool
    var withRelated: Bool = false
    private var baseURL = "https://cdn.marvel.com/content/1x/"
    
    
    init(card: CardHome, withBaseUrl: Bool, withRelated: Bool) {
        self.card = card
        self.withBaseUrl = withBaseUrl
        self.withRelated = withRelated
    }
   
    var body: some View {
        NavigationStack{
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
                        Button(action: {
                            isFavorite.toggle()
                        }, label: {
                            HStack{
                                Image(systemName: isFavorite ? "heart.fill" : "heart" )
                                    .foregroundColor(Color("mClearGray"))
                                    .padding(.leading, 2)
                                    .font(.largeTitle)
                            }.padding()
                        })
                    }
                    if (card.image.filename) != "" {
                        AsyncImage(url: URL(string:  (withBaseUrl ? baseURL : "") + (card.image.filename)) ){ image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(color: .gray, radius: 10)
                                .frame(maxWidth: card.contentType == "article" ? 340 : 160 )
                                
                        }placeholder: {
                            ProgressView()
                        }
                        .padding(.top, card.contentType == "article" ? 0 : -30)
                    }else{
                        ProgressView()
                    }
                    VStack{
                        Text(card.headline)
                            .foregroundStyle(Color(.white))
                            .font(.custom("BentonSans Comp Black", size: 20))
                            .frame(width: 340)
                        Text(card.secondaryText ?? "")
                            .foregroundStyle(Color(.white))
                            .font(.custom("Poppins-Light", size: 16))
                           
                    }.padding(7)
                    
                    VStack(alignment: .leading){
                  
                        Text("Description")
                            .foregroundStyle(Color(.white))
                            .font(.custom("BentonSans Comp Black", size: 26))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                      
                        Text( card.description ?? "")
                            .foregroundStyle(Color(.white))
                            .padding(.horizontal, 30)
                            .font(.custom("Poppins-Light", size: 14))
                    
                        if withRelated{
                            Text(card.contentType == "comic_issue" ? "Characters" : "Comics")
                                .foregroundStyle(Color(.white))
                                .font(.custom("BentonSans Comp Black", size: 26))
                                .padding(.top)
                                .padding(.horizontal, 30)
                        }else{
                            HComicList<NewComicsViewModel>(title: "New Comics", viewModel: newComicsModel)
                        }
                        
                    }
                   
                   
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color("mBackground"))
    }
    
   
}
