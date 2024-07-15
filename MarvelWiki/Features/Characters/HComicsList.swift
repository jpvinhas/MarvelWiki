//
//  HComicsList.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 15/07/24.
//

import SwiftUI

struct HComicsList: View {
    
    private let rows: [GridItem] = [
        GridItem(.flexible(), spacing: 36)
    ]
    
    @ObservedObject var viewModel: CharactersDescriptionViewModel
    var def = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"

    
    var body: some View {
        VStack(alignment: .leading){
                   HStack{
                       Text("Comics")
                           .font(.custom("BentonSans Comp Black", size: 26))
                           .foregroundStyle(Color.white)
                       Spacer()
                      
                   }
                   if viewModel.comics.count != 0 {
                       ScrollView(.horizontal, showsIndicators: false) {
                           LazyHGrid(rows: rows, alignment: .center) {
                               ForEach(viewModel.comics) { comic in
                                   ComicBox(comic: comic)
                                       .frame(maxWidth: 100)
                               }
                           }
                       }.frame(minHeight: 0)
                   }else {
                       HStack{
                           Spacer()
                           Text("No Comics")
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
