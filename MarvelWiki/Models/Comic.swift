//
//  Comic.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 28/06/24.
//

import Foundation

struct Comic: Identifiable, Codable {
    var id: Int?
    var title: String?
    var description: String?
    var modified: String?
    var pageCount: Int?
    var resourceURI: String?
    var thumbnail: Thumbnail
    var creators: Creators
    var characters: Characters
    
    struct Thumbnail: Codable {
        var path: String
    }
    
    struct Creators: Codable {
        let available: Int
        let collectionURI: String
        let items: [Creator]
        let returned: Int
        
        struct Creator: Codable,Hashable {
            let resourceURI: String
            let name: String
            let role: String
        }
    }
    
    struct Characters: Codable {
        let available: Int
        let collectionURI: String
        let items: [ComicCharacter]
        let returned: Int
        
        struct ComicCharacter: Codable {
            let resourceURI: String
            let name: String
        }
    }
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case modified
        case pageCount
        case resourceURI
        case thumbnail
        case creators
        case characters
    }
}
