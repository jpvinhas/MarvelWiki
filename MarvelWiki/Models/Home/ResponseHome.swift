//
//  ResponseHome.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 02/07/24.
//

import Foundation

struct ResponseHome: Codable{
    var status: Int
    var header: HeaderHome
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(Int.self, forKey: .status)
        self.header = try container.decode(HeaderHome.self, forKey: .header)
    }
    
    init(status: Int, header: HeaderHome) {
        self.status = status
        self.header = header
    }
    
    enum CodingKeys: String, CodingKey{
        case status
        case header 
    }
}
