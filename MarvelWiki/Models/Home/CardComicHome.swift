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
    //var description: String?
    var image: ImageCardComicHome
    var link: LinkCardHome
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cardType = try container.decode(String.self, forKey: .cardType)
        self.context = try container.decode(String.self, forKey: .context)
        self.headline = try container.decode(String.self, forKey: .headline)
        //self.description = try container.decode(String.self, forKey: .description)
        self.image = try container.decode(ImageCardComicHome.self, forKey: .image)
        self.link = try container.decode(LinkCardHome.self, forKey: .link)
    }
         
    enum CodingKeys: String, CodingKey{
        case cardType = "card_type"
        case context
        case headline
        //case description
        case image
        case link
    }
    
}

