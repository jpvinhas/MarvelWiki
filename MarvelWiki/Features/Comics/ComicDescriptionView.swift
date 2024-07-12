//
//  ComicDescription.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 09/07/24.
//

import SwiftUI

struct ComicDescriptionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var descriptionViewModel: ComicsDescriptionViewModel
    
    init(comic: Comic) {
        self.descriptionViewModel = ComicsDescriptionViewModel(comic: comic)
    }
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left.circle")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                }
                Spacer()
                Button {
                    descriptionViewModel.isfavorite.toggle()
                } label: {
                    Image(systemName: descriptionViewModel.isfavorite ? "heart.fill": "heart")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                }
            }.padding(.horizontal,30)
            
            ScrollView(.vertical){
                VStack {
                    HStack{
                        Spacer()
                        VStack{
                            if let url = URL(string: "\(descriptionViewModel.comic.thumbnail.path)/\(descriptionViewModel.size).\(descriptionViewModel.ext)") {
                                AsyncImage(url: url) { image in
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
                            }
                            Text("\(formatTitle(title: descriptionViewModel.comic.title ?? ""))")
                                .font(.custom("BentonSans Comp Black", size: 25))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .padding(.top,5)
                            Text("\(formatYear(title: descriptionViewModel.comic.modified ?? "No Year"))")
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
                            let items = getWriters()
                            Text("\(items.first?.name ?? "Any writer" )")
                                .font(.custom("Poppins-Light", size: 14))
                                .foregroundColor(Color("mClearGray"))
                            
                        }
                        Spacer()
                        
                        VStack(alignment: .trailing){
                            Text("PENCILLER:")
                                .font(.custom("BentonSans Comp Black", size: 16))
                                .foregroundColor(.white)
                            let items = getPencilers()
                            Text("\(items.first?.name ?? "Any penciler" )")
                                .font(.custom("Poppins-Light", size: 14))
                                .foregroundColor(Color("mClearGray"))
                        }
                    }.padding(.top)
                    HStack {
                        Text("\(descriptionViewModel.comic.description ?? "")")
                            .frame(maxWidth: .infinity)
                            .font(.custom("Poppins-Light", size: 14))
                            .foregroundColor(Color("mClearGray"))
                    }
                    .padding(.top,5)
                }.padding(.horizontal,30)
                if descriptionViewModel.available != 0 {
                    HCharactersList(viewModel: descriptionViewModel)
                }
                if let url = getUrl().first?.url{
                    NavigationLink(destination: LoadingWebView(url: URL(string: url)!)) {
                        HStack {
                            Text("Open More Details")
                                .font(.custom("Poppins-Regular", size: 16))
                                .foregroundColor(.white)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color("mRed"))
                        .cornerRadius(10)
                    }.padding()
                }
            }
        }
        .background(Color("mBackground"))
        .navigationBarBackButtonHidden(true)
        .onAppear{
            print("carregando descricao")
            print(descriptionViewModel.comic.urls)
            descriptionViewModel.getCharactersByComic()
        }
    }
    private func getUrl() -> [Comic.Url] {
        return descriptionViewModel.comic.urls.filter { $0.type.contains("detail") }
    }
    private func getPencilers() -> [Comic.Creators.Creator] {
        return descriptionViewModel.comic.creators.items.filter { $0.role.contains("penciler") }
    }

    private func getWriters() -> [Comic.Creators.Creator] {
        return descriptionViewModel.comic.creators.items.filter { $0.role.contains("writer") }
    }

    func formatTitle(title: String) -> String {
        let components = title.components(separatedBy: " (")

        let formatedtitle = components[0].trimmingCharacters(in: .whitespaces)

        return formatedtitle
    }
    func formatYear(title: String) -> String {
        let components = title.components(separatedBy: "-")

        let formatedtitle = components[0].trimmingCharacters(in: .whitespaces)

        return formatedtitle
    }
}
