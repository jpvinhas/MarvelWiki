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
    private let limit = 18
    private let startYear = 2024
    
    func getComics( completion: @escaping (_ data: Data) -> Void){
          
        let urlString = "\(baseURL)\(urlComics)?limit=\(limit)&ts=\(timesTamp)&apikey=\(apikey)&hash=\(hash)"
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
    func getComicsByYear(startYear: Int, completion: @escaping (_ data: Data) -> Void){
          
        let urlString = "\(baseURL)\(urlComics)?startYear=\(startYear)&limit=\(limit)&ts=\(timesTamp)&apikey=\(apikey)&hash=\(hash)"
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
    
    func getComicById(id: Int, completion: @escaping (_ comic: [Comic]) -> Void){
        
        let urlString = "\(baseURL)\(urlComics)/\(id)?ts=\(timesTamp)&apikey=\(apikey)&hash=\(hash)"
        let url = URL(string: urlString)
        guard let url = url else {return}
        
        var requestHeader = URLRequest(url: url)
        requestHeader.httpMethod = "GET"
      
        URLSession.shared.dataTask(with: requestHeader) { data, _, _ in
            guard let data = data else{
                return
            }
            let response = try? JSONDecoder().decode(MarvelResponse<Comic>.self, from: data)
            completion(response?.data?.results ?? [])
        }.resume()
    }
}
