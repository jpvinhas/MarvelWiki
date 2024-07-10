//
//  ComicDescription.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 09/07/24.
//

import SwiftUI

struct ComicDescription: View {
    var body: some View {
        VStack{
            HStack{
                Button {
                    print("back")
                } label: {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                }
                Spacer()
                Button {
                    print("fav")
                } label: {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                }
            }.padding(.horizontal,30)
            ScrollView(.vertical){
                VStack{
                    HStack{
                        Spacer()
                        VStack{
                            Image("Imagetest")
                            Text("Venom(2021)")
                                .font(.custom("BentonSans Comp Black", size: 25))
                                .foregroundColor(.white)
                            Text("2022")
                                .font(.custom("Poppins-Light", size: 16))
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: 160)
                        .padding(.top,50)
                        Spacer()
                    }.padding(.top,-45)
                    HStack{
                        VStack(alignment: .leading){
                            Text("WRITER:")
                                .font(.custom("BentonSans Comp Black", size: 16))
                                .foregroundColor(.white)
                            Text("Torunn Fronbekk")
                                .font(.custom("Poppins-Light", size: 14))
                                .foregroundColor(Color("mClearGray"))
                        }
                        Spacer()
                        
                        VStack(alignment: .trailing){
                            Text("PENCILLER:")
                                .font(.custom("BentonSans Comp Black", size: 16))
                                .foregroundColor(.white)
                            Text("Julius Ohta")
                                .font(.custom("Poppins-Light", size: 14))
                                .foregroundColor(Color("mClearGray"))
                        }
                    }.padding(.top)
                    HStack {
                        Text("A SYMBIOTIC FREE-FOR-ALL! Freshly united and teamed up, VENOM and TOXIN fight like hell to save one of the Marvel Universe's greatest hero from the darkness within her.")
                            .font(.custom("Poppins-Light", size: 14))
                            .foregroundColor(Color("mClearGray"))
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.top,5)
                    .padding(.horizontal,-5)
                    
                }
                .padding(.horizontal,30)
            }
        }
        .padding(.top,20)
        .background(Color("mBackground"))
    }
}

#Preview {
    ComicDescription()
}
