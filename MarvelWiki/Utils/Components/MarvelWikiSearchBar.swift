//
//  MarvelWikiSearchBar.swift
//  MarvelWiki
//
//  Created by Ricardo Silva Vale on 02/07/24.
//

import SwiftUI


struct MarvelWikiSearchBar: View {
    @State private var searchText = ""
    
    var body: some View {
        
        VStack{
            Image("MWhorizontal")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 230, height: 62)
                           
            HStack{
                TextField("", text: $searchText, prompt: Text("Busque").foregroundColor(.mGray))
                        .autocapitalization(.none)
                        .foregroundColor(.mGray)
                        .padding(.leading, 20)
                Button(action: {
                    print("pesquisarr")
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

#Preview {
    MarvelWikiSearchBar()
}
