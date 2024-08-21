//
//  Routes.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct Routes: View {
    
    @StateObject private var coordinator = Coordinator()
        
    var body: some View {
        VStack {
            Spacer()
            coordinator.currentView()
            Spacer()
            TabBarView(selectedTab: $coordinator.selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color("mBackground"))
    }
}


#Preview {
    Routes()
}
