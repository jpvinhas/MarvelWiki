//
//  MoreComicsView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 08/07/24.
//

import SwiftUI

struct MoreComicsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: ComicsViewModel

    var title: String?
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .font(.system(size: 20).bold())
                        .foregroundColor(Color("mClearGray"))
                }
                Spacer()
                Text(title ?? "")
                    .font(.custom("BentonSans Comp Black", size: 30))
                    .foregroundColor(Color.white)
                
                Spacer()
            }
            .padding(30)
            ComicsList(comics: title == "New Comics" ? $viewModel.newComics : $viewModel.comics, moreAction: title == "New Comics" ? viewModel.loadNewComics : viewModel.loadComics)
                .onDisappear{
                    if title == "New Comics" {
                        viewModel.newComics?.removeSubrange(15..<viewModel.newOffset)
                        viewModel.newOffset = viewModel.limit
                    }else {
                        let size = viewModel.comics?.count ?? 15
                        viewModel.comics?.removeSubrange(15..<size)
                        viewModel.allOffset = viewModel.limit
                    }
                }
        }
        .background(Color("mBackground"))
        .navigationBarBackButtonHidden(true)
    }
}
