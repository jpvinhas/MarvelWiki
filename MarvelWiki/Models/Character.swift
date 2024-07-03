//
//  Character.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 28/06/24.
//

import Foundation

struct Character: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: Thumbnail
    var resourceURI: String
    var comics: Comics
    var urls: [URLItem]

    struct Thumbnail: Codable {
        var path: String
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
//struct MarvelResponse: Codable {
//    let code: Int
//    let status: String
//    let copyright: String
//    let attributionText: String
//    let attributionHTML: String
//    let etag: String
//    let data: MarvelData
//}
//
//struct MarvelData: Codable {
//    let offset: Int
//    let limit: Int
//    let total: Int
//    let count: Int
//    let results: [Comic]
//}
