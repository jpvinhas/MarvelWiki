//
//  ComicsHome.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 02/07/24.
//

import Foundation

struct ComicsHome: Codable{
    var link: String
    var title: String
    var content: [CardComicHome]
}
