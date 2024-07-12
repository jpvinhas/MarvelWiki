//
//  ComicDescription.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 09/07/24.
//

import SwiftUI

struct ComicDescriptionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var isfavorite = false
    
    var comic: Comic?
    private var ext = "jpg"
    private var size = "portrait_fantastic"
    
    init(comic: Comic) {
        self.comic = comic
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
                    isfavorite.toggle()
                } label: {
                    Image(systemName: isfavorite ? "heart.fill": "heart")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                }
            }.padding(.horizontal,30)
            
            ScrollView(.vertical){
                    HStack{
                        Spacer()
                        VStack{
                            if let url = URL(string: "\(comic?.thumbnail.path ?? "")/\(size).\(ext)") {
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
                            Text("\(formatTitle(title: comic?.title ?? ""))")
                                .font(.custom("BentonSans Comp Black", size: 25))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .padding(.top,5)
                            Text("\(formatYear(title: comic?.modified ?? "No Year"))")
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
                            if let items = getWriters() {
                                //ForEach(items, id: \.self) { index in
                                Text("\(items.first?.name ?? "Any writer" )")
                                        .font(.custom("Poppins-Light", size: 14))
                                        .foregroundColor(Color("mClearGray"))
                               // }
                            }
                        }
                        Spacer()
                        
                        VStack(alignment: .trailing){
                            Text("PENCILLER:")
                                .font(.custom("BentonSans Comp Black", size: 16))
                                .foregroundColor(.white)
                            if let items = getPencilers() {
                                ForEach(items, id: \.self) { index in
                                    Text("\(index.name)")
                                        .font(.custom("Poppins-Light", size: 14))
                                        .foregroundColor(Color("mClearGray"))
                                }
                            }
                        }
                    }.padding(.top)
                    HStack {
                        Text("\(comic?.description ?? "")")
                            .frame(maxWidth: .infinity)
                            .font(.custom("Poppins-Light", size: 14))
                            .foregroundColor(Color("mClearGray"))
                    }
                    .padding(.top,5)
                    
                }
                .padding(.horizontal,30)
        }.background(Color("mBackground"))
        .navigationBarBackButtonHidden(true)
    }
    private func getPencilers() -> [Comic.Creators.Creator]? {
       guard let items = comic?.creators.items else {
           return nil
       }
       return items.filter { $0.role.contains("penciler") }
   }
    private func getWriters() -> [Comic.Creators.Creator]? {
       guard let items = comic?.creators.items else {
           return nil
       }
       return items.filter { $0.role.contains("writer") }
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
