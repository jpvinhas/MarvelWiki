//
//  HomeView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var marvelResponse: MarvelResponse<Comic>?
    var ext = "jpg"
    var size = "portrait_medium"
    
    var body: some View {
        NavigationView {
            VStack{
                MarvelWikiSearchBar()
                    .padding(.top,0)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color("mBackground"))
        }
    }
}

#Preview {
    HomeView()
}
