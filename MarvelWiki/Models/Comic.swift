//
//  Comic.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 28/06/24.
//

import Foundation

struct Comic: Identifiable, Codable {
    var id: Int
    var title: String
    var description: String
    var pageCount: Int
    var resourceURI: String
    var thumbnail: Thumbnail
    var creators: Creators
    var characters: [Character]

    struct Thumbnail: Codable {
        var path: String
    }
    struct Creators: Codable {
        let available: Int
        let items: [Creator]
        let returned: Int

        struct Creator: Codable, Identifiable {
            let resourceURI: String
            let name: String
            let role: String
            
            var id: String {
                resourceURI
            }
        }
    }
}
