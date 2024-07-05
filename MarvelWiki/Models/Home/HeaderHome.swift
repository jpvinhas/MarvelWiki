//
//  HeaderHome.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 02/07/24.
//

import Foundation

struct HeaderHome: Codable{
    var componentType: String
    var primaryLinks: [PrimaryLink]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.componentType = try container.decode(String.self, forKey: .componentType)
        self.primaryLinks = try container.decode([PrimaryLink].self, forKey: .primaryLinks)
    }
    
    init(componentType: String, primaryLinks: [PrimaryLink]) {
        self.componentType = componentType
        self.primaryLinks = primaryLinks
    }
    
    enum CodingKeys: String, CodingKey{
        case componentType = "component_type"
        case primaryLinks = "primary_links"
    }
}
