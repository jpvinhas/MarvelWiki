//
//  ApiService.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 01/07/24.
//

import Foundation

class ApiService {
    
    static var singleton = ApiService()
    private let baseURL = "https://www.marvel.com/api/tallus"
    private let query = URLQueryItem(name: "referer", value: "https%3A%2F%2Fwww.marvel.com%2Fcomics%2Fissue%2F113014%2Fblood_hunt_2024_4")
    
    func getHomeJson(completion: @escaping (_ primaryLinks: [PrimaryLink]) -> Void) {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = [query]
        
        guard let url = urlComponents?.url else {
            print("Invalid URL")
            completion([])
            return
        }
        
        var requestHeader = URLRequest(url: url)
        requestHeader.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: requestHeader) { data, response, error in
            if let error = error {
                print("Request failed with error: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ResponseHome.self, from: data)
                completion(response.header.primaryLinks)
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion([])
            }
        }.resume()
    }
}

