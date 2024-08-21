//
//  Coordinator.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 21/08/24.
//

import Foundation
import SwiftUI

class Coordinator: ObservableObject {
    @Published var selectedTab: TabIcon = .Home
    
    // Armazena instâncias das views
    private(set) var homeView = HomeView()
    private(set) var comicsView = ComicsView()
    private(set) var charactersView = CharactersView()
    private(set) var favoritesView = FavoritesView()
    
    // Método para alterar a aba selecionada
    func selectTab(_ tab: TabIcon) {
        selectedTab = tab
    }
    
    // Método para obter a view atual com base na aba selecionada
    func currentView() -> some View {
        switch selectedTab {
        case .Home:
            return AnyView(homeView)
        case .Comics:
            return AnyView(comicsView)
        case .Characters:
            return AnyView(charactersView)
        case .Favorite:
            return AnyView(favoritesView
                .foregroundStyle(Color("mClearGray")))
        }
    }
}
