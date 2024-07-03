//
//  LinkCardHome.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 02/07/24.
//

import Foundation

struct LinkCardHome: Codable{
    var link: String
    var title: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.link = try container.decode(String.self, forKey: .link)
        self.title = try container.decode(String.self, forKey: .title)
    }
    
    enum CodingKeys: String, CodingKey{
        case link
        case title
    }
}
