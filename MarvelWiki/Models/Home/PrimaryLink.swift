//
//  PrimaryLink.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 02/07/24.
//

import Foundation


struct PrimaryLink: Codable{
    var link: String
    var title: String
    var content: [CardComicHome]
    
    init(link: String, title: String, content: [CardComicHome]){
        self.link = link
        self.title = title
        self.content = content
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.link = try container.decode(String.self, forKey: .link)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode([CardComicHome].self, forKey: .content)
    }
    
    enum CodingKeys: String, CodingKey{
        case link
        case title
        case content
    }
}
