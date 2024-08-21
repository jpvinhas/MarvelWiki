//
//  ApiServiceComic.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 02/07/24.
//
import CryptoKit
import Foundation

class ApiServiceComic{
    
    static var singleton = ApiServiceComic()
       
    private let timesTamp: String
    private let apikey: String
    private let privateKey: String
    private let hash: String
    private let baseURL: String = "https://gateway.marvel.com:443"
    private let urlComics: String = "/v1/public/comics"
    private let limit: Int = 10
    private let startYear: Int = 2024

    private init() {
       self.timesTamp = "\(Int(Date().timeIntervalSince1970))"
       self.apikey = "cf240964f461c3bed5535b5c1ff1a186"
       self.privateKey = "6bd46fcbd061efa307bbbeedeca78aaaeb4330a5"
       self.hash = ApiServiceComic.generateMD5Hash(timestamp: self.timesTamp, privateKey: self.privateKey, publicKey: self.apikey)
    }

    private static func generateMD5Hash(timestamp: String, privateKey: String, publicKey: String) -> String {
       let toHash = "\(timestamp)\(privateKey)\(publicKey)"
       let digest = Insecure.MD5.hash(data: toHash.data(using: .utf8)!)
       return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    
    func getComicsByName(tileStartsWith: String,offset: Int, completion: @escaping (_ data: Data) -> Void){
        print("get comics by name")
        let urlString = "\(baseURL)\(urlComics)?titleStartsWith=\(tileStartsWith)&offset=\(offset)&ts=\(timesTamp)&apikey=\(apikey)&hash=\(hash)"
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
    func getComicsByYear(startYear: Int, offset: Int, completion: @escaping (_ data: Data) -> Void) {
        print("get comics by year")

        let urlString = "\(baseURL)\(urlComics)?startYear=\(startYear)&limit=\(limit)&offset=\(offset)&ts=\(timesTamp)&apikey=\(apikey)&hash=\(hash)"
        guard let url = URL(string: urlString) else { return }
        
        var requestHeader = URLRequest(url: url)
        requestHeader.httpMethod = "GET"
        requestHeader.timeoutInterval = 120
        
        func performRequest(retries: Int) {
            URLSession.shared.dataTask(with: requestHeader) { data, _, error in
                if let error = error as NSError?, error.code == NSURLErrorTimedOut, retries > 0 {
                    performRequest(retries: retries - 1) // Retry the request
                } else {
                    if let data = data {
                      completion(data)
                  }
                }
            }.resume()
        }
        
        performRequest(retries: 3) // Try up to 3 times
    }
    func getComics(offset: Int, completion: @escaping (_ data: Data) -> Void) {
        print("get all comics")
        let urlString = "\(baseURL)\(urlComics)?limit=\(limit)&offset=\(offset)&ts=\(timesTamp)&apikey=\(apikey)&hash=\(hash)"
        guard let url = URL(string: urlString) else { return }
        
        var requestHeader = URLRequest(url: url)
        requestHeader.httpMethod = "GET"
        requestHeader.timeoutInterval = 120 // Aumentar o tempo limite, se necessário

        func performRequest(retries: Int) {
            URLSession.shared.dataTask(with: requestHeader) { data, _, error in
                if let error = error as NSError?, error.code == NSURLErrorTimedOut || error.code == NSURLErrorNetworkConnectionLost, retries > 0 {
                    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
                        performRequest(retries: retries - 1) // Retry after a delay
                    }
                } else {
                    if let data = data {
                        completion(data)
                    }
                }
            }.resume()
        }

        performRequest(retries: 3) // Tenta até 3 vezes em caso de timeout
    }

    func getCharactersByComic(id: Int, offset: Int, completion: @escaping (_ data: Data) -> Void){
        print("get characters by comic")
        let urlString = "\(baseURL)\(urlComics)/\(id)/characters?offset=\(offset)&ts=\(timesTamp)&apikey=\(apikey)&hash=\(hash)"
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
