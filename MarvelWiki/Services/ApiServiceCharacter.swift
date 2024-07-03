//
//  ApiServiceCharacter.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 02/07/24.
//

import Foundation

class ApiServiceCharacter {
    
    static var singleton = ApiServiceCharacter()
    
    private let timesTamp = "1719323506"
    private let apikey = "94e11007ccd3554185532827d0ad1bcc"
    private let hash = "577688d4b287d1393f4c3103644aa1f3"
    private let baseURL: String = "https://gateway.marvel.com:443"
    private let urlCharacters: String = "/v1/public/characters"
    
    
    
}
