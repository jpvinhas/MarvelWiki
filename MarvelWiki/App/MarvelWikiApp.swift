//
//  MarvelWikiApp.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 28/06/24.
//

import SwiftUI

@main
struct MarvelWikiApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Routes()
        }
    }
}
