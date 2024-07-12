//
//  MoreComicsView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 08/07/24.
//

import SwiftUI

struct MoreComicsView<T: ComicsModel>: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: T

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
            ComicsList(viewModel: viewModel)
                .onDisappear{
                    let size = viewModel.comics.count
                    viewModel.comics.removeSubrange(20..<size)
                    viewModel.offset = viewModel.limit
                }
        }
        .background(Color("mBackground"))
        .navigationBarBackButtonHidden(true)
    }
}
