//
//  TesteApp.swift
//  Teste
//
//  Created by João Pedro Borges on 21/08/24.
//

import SwiftUI

@main
struct TesteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
