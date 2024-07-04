//
//  ApiService.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 01/07/24.
//

import Foundation


class ApiService{
    
    static var singleton = ApiService()
    private let headerTest = HeaderHome.init(componentType: "1", primaryLinks: [])
   
    
    private let baseURL = "https://www.marvel.com/api/tallus"
    private let query = URLQueryItem(name: "referer", value: "https%3A%2F%2Fwww.marvel.com%2Fcomics%2Fissue%2F113014%2Fblood_hunt_2024_4")
    
    func getHomeJson(completion: @escaping (_ primaryLinks: [PrimaryLink]) -> Void) {
        let url = URL(string: baseURL)
        guard let url = url else { return }
        var requestHeader = URLRequest(url: url)
        requestHeader.httpMethod = "GET"
        requestHeader.url?.append(queryItems: [query])
        
        URLSession.shared.dataTask(with: requestHeader) { (data, error, response) in
            guard let data = data else{
                return
            }
            let response = try? JSONDecoder().decode(ResponseHome.self, from: data)
            completion( response?.header.primaryLinks ?? [])
        }.resume()
    }
}
