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
    private let limit = 15
    private let startYear = 2024
    
    func getComicsByName(tileStartsWith: String, completion: @escaping (_ data: Data) -> Void){
          
        let urlString = "\(baseURL)\(urlComics)?titleStartsWith=\(tileStartsWith)&ts=\(timesTamp)&apikey=\(apikey)&hash=\(hash)"
        let url = URL(string: urlString)
        guard let url = url else {return}
        
        var requestHeader = URLRequest(url: url)
        requestHeader.httpMethod = "GET"
      
        URLSession.shared.dataTask(with: requestHeader) { data, _, _ in
          if let data = data {
              completion(data)
          }
        }.resume()
    }
    func getComicsByYear(startYear: Int,offset: Int, completion: @escaping (_ data: Data) -> Void){
          
        let urlString = "\(baseURL)\(urlComics)?startYear=\(startYear)&limit=\(limit)&offset=\(offset)&ts=\(timesTamp)&apikey=\(apikey)&hash=\(hash)"
        let url = URL(string: urlString)
        guard let url = url else {return}
        
        var requestHeader = URLRequest(url: url)
        requestHeader.httpMethod = "GET"
      
        URLSession.shared.dataTask(with: requestHeader) { data, _, _ in
          if let data = data {
              completion(data)
          }
        }.resume()
    }
    func getComics(offset: Int, completion: @escaping (_ data: Data) -> Void) {
        let urlString = "\(baseURL)\(urlComics)?limit=\(limit)&offset=\(offset)&ts=\(timesTamp)&apikey=\(apikey)&hash=\(hash)"
        let url = URL(string: urlString)
        guard let url = url else { return }
        
        var requestHeader = URLRequest(url: url)
        requestHeader.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: requestHeader) { data, _, _ in
            if let data = data {
                completion(data)
            }
        }.resume()
    }
}
