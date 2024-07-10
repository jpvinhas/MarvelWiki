//
//  ComicsList.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 03/07/24.
//

import SwiftUI

struct ComicsList: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    @Binding var comics: [Comic]?
    var moreAction: () -> Void

   
    var body: some View {
        VStack(alignment: .leading){
            if comics != nil {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredComics()) { comic in
                            ComicBox(comic: comic)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.top,5)
                    .padding(.horizontal,30)
                    loadbuttom
                }
            }else {
                Spacer()
                ProgressView("Loading...")
                    .foregroundStyle(Color("mClearGray"))
                    .frame(minWidth: 390)
                Spacer()
            }
        }
    }
    var loadbuttom: some View {
        Button {
            DispatchQueue.main.async {
                moreAction()
            }
        } label: {
            HStack{
                Text("Load More")
                    .font(.custom("Poppins-Bold", size: 16))
                    .foregroundColor(Color.white)
                Image(systemName: "arrow.clockwise.circle")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
            }
            .padding()
            .frame(minWidth: 50)
            .background(Color("mRed"))
            .cornerRadius(10)
        }
    }
    private func filteredComics() -> [Comic] {
        let def = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
        return comics?.filter { comic in
            return comic.thumbnail.path != def
        } ?? []
    }
}
