//
//  ComicsModel.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 11/07/24.
//

import Foundation

protocol ComicsModel: ObservableObject {
    var comics: [Comic] { get set }
    var isLoading: Bool { get set }
    var available: Int { get set }
    var offset: Int { get set }
    var limit: Int { get }
    
    func loadComics() -> Void
    
}
