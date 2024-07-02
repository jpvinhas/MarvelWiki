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
                Text("Home")
                NavigationLink(destination: DescriptionView(), label: {
                    Text("Open Description")
                })
            }
        }
    }
}

#Preview {
    HomeView()
}
