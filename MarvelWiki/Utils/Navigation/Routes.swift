//
//  Routes.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct Routes: View {
    @State private var selectedTab: TabIcon = .Home

    var body: some View {
        VStack {
            Spacer()
            switch selectedTab {
            case .Home:
                HomeView()
            case .Comics:
                ComicsView()
            case .Characters:
                CharactersView()
            case .Favorite:
                HomeView()
            }
            Spacer()
            TabBarView(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color("mBackground"))
    }
}


#Preview {
    Routes()
}
