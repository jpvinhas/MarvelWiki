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
    private let baseURL: String = "https://gateway.marvel.com:443/v1/public/characters"
    
    func getCharacters (page: Int = 0, limit: Int = 20, completion: @escaping (_ charactersResponse: [Character])  -> Void ){
        let queryTs = URLQueryItem(name: "ts", value: timesTamp)
        let queryApikey = URLQueryItem(name: "apikey", value: apikey)
        let queryHash = URLQueryItem(name: "hash", value: hash)
        let queryOffset = URLQueryItem(name: "offset", value: "\(page * limit)")
        let queryLimit = URLQueryItem(name: "limit", value: "\(limit)")
       
        var url = URL(string: baseURL)
        url?.append(queryItems: [queryTs, queryApikey, queryHash, queryLimit, queryOffset])
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else {return}
            let jsonDecoder = JSONDecoder()
            do {
                let charactersResponse = try jsonDecoder.decode(MarvelResponse<Character>.self, from: data)
                if let results =  charactersResponse.data?.results{
                    completion(results)
                    
                }else {
                    completion([])
                }
                    
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
        }
            
        .resume()
       
        }
        
    
    func getCharacterId (characterId: Int, completion: @escaping  (_ characterIdResponse: Character?) -> Void){
        let queryTs = URLQueryItem(name: "ts", value: timesTamp)
        let queryApikey = URLQueryItem(name: "apikey", value: apikey)
        let queryHash = URLQueryItem(name: "hash", value: hash)
        
        let characterURLString = "\(baseURL)/\(characterId)"
        
        var url = URL(string: characterURLString)
        url?.append(queryItems: [queryTs, queryApikey, queryHash])
        guard let url = url else {return}
         
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else {return}
            do {
                let characterResponse = try JSONDecoder().decode(MarvelResponse<Character>.self, from: data)
                completion(characterResponse.data?.results?.first)
            } catch{
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
                
        }
        .resume()
    }
    
    
    func fecthCharacterName (characterName: String, completion: @escaping (_ nameStartsWithResponse: [Character]?) -> Void){
        let queryTs = URLQueryItem(name: "ts", value: timesTamp)
        let queryApikey = URLQueryItem(name: "apikey", value: apikey)
        let queryHash = URLQueryItem(name: "hash", value: hash)
        let querynameStartsWith = URLQueryItem(name: "nameStartsWith", value: characterName)
        let characterNameURLString = "\(baseURL)"
       
        
        var url = URL(string: characterNameURLString)
        url?.append(queryItems: [queryTs, queryApikey,queryHash, querynameStartsWith])
        guard let url = url else {return}
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else {return}
            let characterNameResponse = try? JSONDecoder().decode(MarvelResponse<Character>.self, from: data)
            completion(characterNameResponse?.data?.results ?? [])
       }
        .resume()
        
        
        
          
    }
    
        
    
}
