//
//  SwiftUIView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 11/07/24.

import SwiftUI

struct HCharactersList: View {
    private let rows: [GridItem] = [
        GridItem(.flexible(), spacing: 36),
    ]
    
    @ObservedObject var viewModel : ComicsDescriptionViewModel
    var def = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Characters")
                    .font(.custom("BentonSans Comp Black", size: 26))
                    .foregroundStyle(Color.white)
                Spacer()
                //NavigationLink(destination: MoreComicsView<T>(viewModel: viewModel)){
                    Text("See All")
                        .font(.custom("BentonSans Comp Black", size: 15))
                        .foregroundStyle(Color.white)
                        .opacity(0.5)
                //}.navigationBarBackButtonHidden(true)
            }
            if viewModel.characters.count != 0 {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center) {
                        ForEach(viewModel.characters) { character in
                            CharacterBox(character: character)
                                .frame(maxWidth: 100)
                        }
                    }
                }.frame(minHeight: 0)
            }else {
                HStack{
                    Spacer()
                    Text("No Characters")
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundStyle(Color("mClearGray"))
                    Spacer()
                }.frame(minHeight: 120)
            }
        }
        .padding(.top,10)
        .padding(.horizontal,30)

    }
}
