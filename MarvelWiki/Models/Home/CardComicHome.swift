//
//  CardComicHome.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 02/07/24.
//

import Foundation

struct CardHome: Identifiable, Codable{
    var id = UUID()
    var cardType: String
    var context: String
    var headline: String
    var description: String?
    var image: ImageCardComicHome
    var link: LinkCardHome
    var secondaryText: String?
    var contentType: String?
    
    enum CodingKeys: String, CodingKey{
        case cardType = "card_type"
        case context
        case headline
        case description
        case image
        case link
        case secondaryText = "secondary_text"
        case contentType = "content_type"
    }
    
}

