//
//  CharactersDescriptionViewModel.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 15/07/24.
//

import Foundation


class CharactersDescriptionViewModel: ObservableObject {
    
    private let apiServiceCharacter = ApiServiceCharacter.singleton
    
    @Published var character: Character
    @Published var comics: [Comic] = []
    
    @Published var isLoading: Bool = false
    @Published var available: Int = 0
    
    internal var offset = 0
    internal var limit  = 10
    
    init(character: Character){
        self.character = character
    }
    
    func getComicsByCharacter(){
        isLoading = true
        
        apiServiceCharacter.getComicsByCharacter(id: character.id, offset: offset){ [weak self] data in
            guard let self = self else { return }
                        
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let marvelResponse = try decoder.decode(MarvelResponse<Comic>.self, from: data)
                    let comics = marvelResponse.data?.results ?? []
                    let uniqueNewCharacters = comics.filter { newCharacter in
                        !(self.comics.contains { $0.id == newCharacter.id })
                    }
                    self.comics.append(contentsOf: uniqueNewCharacters)
                    let total = marvelResponse.data?.total ?? 0
                    self.available = total
                    self.offset += self.limit
                    self.isLoading = false
                } catch {
                    print("Erro ao decodificar JSON:", error.localizedDescription)
                }
            }
            
        }
    }
    
}
