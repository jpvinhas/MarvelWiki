//
//  MarvelWikiSearchBar.swift
//  MarvelWiki
//
//  Created by Ricardo Silva Vale on 02/07/24.
//

import SwiftUI


struct MarvelWikiSearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    @Binding var search: Bool

    var body: some View {
        
        VStack{
            HStack{
                if isSearching {
                    Button {
                        isSearching.toggle()
                        searchText = ""
                    } label: {
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 20).bold())
                            .foregroundColor(Color("mClearGray"))
                    }.frame(height: 62)
                        .padding(.trailing,30)
                        .padding(.leading,20)
                }else{
                    Spacer()
                }
                Image("MWhorizontal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 230, height: 62)
                Spacer()
            }
                           
            HStack{
                TextField("", text: $searchText, prompt: Text("Busque").foregroundColor(.mGray))
                        .autocapitalization(.none)
                        .foregroundColor(.mGray)
                        .padding(.leading, 20)
                Button(action: {
                    if isSearching {
                        search.toggle()
                    }else {
                        isSearching.toggle()
                    }
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("mGray"))
                        .padding(.trailing,15)
                })
                
            }
            .frame(width: 344, height: 46)
            .background(Color("tabBlue").cornerRadius(10.0))
            
        }
        
    }
}
