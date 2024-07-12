//
//  Character.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 28/06/24.
//

import Foundation

struct Character: Identifiable, Codable, Equatable {
      
    var id: Int
    var name: String
    var description: String
    var thumbnail: Thumbnail
    var resourceURI: String
    var modified: Date?
    var comics: Comics
    var urls: [URLItem]

    struct Thumbnail: Codable {
        var path: String
        var ext: String
        
        enum CodingKeys: String, CodingKey {
            case path
            case ext = "extension"
        }
               
    }
    
    static func == (lhs: Character, rhs: Character) -> Bool{
        return lhs.id == rhs.id
    }
    
    
    struct Comics: Codable {
        var available: Int
        var collectionURI: String
        var items: [ComicItem]
        var returned: Int

        struct ComicItem: Codable {
            var resourceURI: String
            var name: String
        }
    }

    struct URLItem: Codable {
        var type: String
        var url: String
    }
}
