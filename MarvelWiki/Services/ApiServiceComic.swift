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
    private let limit: Int = 20
    private let startYear: Int = 2024

    private init() {
       self.timesTamp = "\(Int(Date().timeIntervalSince1970))"
       self.apikey = "94e11007ccd3554185532827d0ad1bcc"
       self.privateKey = "6ccfec6ddc0702f56dc1e4b6c32fcb3e4e5deb76"
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
    func getComicsByYear(startYear: Int,offset: Int, completion: @escaping (_ data: Data) -> Void){
        print("get comics by year")
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
        print("get all comics")
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
