//
//  HomeDescription.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 11/07/24.
//

import SwiftUI

struct HomeDescription: View {
    
    @Environment(\.presentationMode) var presentationMode
    //@StateObject private var comicsViewModel: ComicsViewModel = ComicsViewModel()
    @State var card: CardHome
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
                            
                        }, label: {
                            HStack{
                                Image(systemName: "heart")
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
                            //.lineLimit(1)
                        Text(card.secondaryText ?? "")
                            .foregroundStyle(Color(.white))
                           
                    }.padding(7)
                    
                    VStack{
                      
                        Text("Description")
                            .foregroundStyle(Color(.white))
                            .font(.custom("BentonSans Comp Black", size: 20))
                            
                    }.padding()
                    VStack(alignment: .leading){
                        Text( card.description ?? "")
                           
                            .foregroundStyle(Color(.white))
                            .font(.system(size: 14))
                            .padding(.horizontal)
                    }
                   
                    if withRelated{
                        Text(card.contentType == "comic_issue" ? "Characters" : "Comics")
                            .foregroundStyle(Color(.white))
                            .font(.custom("BentonSans Comp Black", size: 20))
                            .padding()
                    }
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color("mBackground"))
    }
    
   
}
