//
//  ApiServiceComic.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 02/07/24.
//

import Foundation

class ApiServiceComic{
    
    static var singleton = ApiServiceComic()
    
    private let timesTamp = "1719323506"
    private let apikey = "94e11007ccd3554185532827d0ad1bcc"
    private let hash = "577688d4b287d1393f4c3103644aa1f3"
    private let baseURL: String = "https://gateway.marvel.com:443"
    private let urlComics: String = "/v1/public/comics"
    
    func getComics( completion: @escaping (_ data: Data) -> Void){
          
        let urlString = "\(baseURL)\(urlComics)?ts=\(timesTamp)&apikey=\(apikey)&hash=\(hash)"
        let url = URL(string: urlString)
        guard let url = url else {return}
        
        print(url)
        
        var requestHeader = URLRequest(url: url)
        requestHeader.httpMethod = "GET"
      
        URLSession.shared.dataTask(with: requestHeader) { data, _, _ in
          if let data = data {
              completion(data)
          }
        }.resume()
  }
}
