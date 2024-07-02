//
//  HomeView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack{
                MarvelWikiSearchBar()
                Spacer()
                NavigationLink(destination: DescriptionView(), label: {
                    Text("Open Description")
                })
                
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
