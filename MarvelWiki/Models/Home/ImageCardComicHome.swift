//
//  ImageCardComicHome.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 02/07/24.
//

import Foundation

struct ImageCardComicHome: Codable{
    var filename: String
    var alt: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.filename = try container.decode(String.self, forKey: .filename)
        self.alt = try container.decode(String.self, forKey: .alt)
    }
    
    enum CodingKeys: String, CodingKey{
        case filename
        case alt
    }
}
