//
//  ComicDescriptionViewModel.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 12/07/24.
//

import Foundation
import SwiftUI

class ComicsDescriptionViewModel: ObservableObject {
    
    private let apiService = ApiServiceComic.singleton
    
    @Published var comic: Comic
    @Published var characters: [Character] = []
    
    @Published var isfavorite = false
    @Published var isLoading: Bool = false
    @Published var available: Int = 0
    internal var offset = 0
    internal var limit = 20
    
    let ext = "jpg"
    let size = "portrait_fantastic"
    
    init(comic: Comic) {
        self.comic = comic
    }
    
    func getCharactersByComic() {
        isLoading = true
        
        apiService.getCharactersByComic(id: comic.id, offset: offset) { [weak self] data in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let marvelResponse = try decoder.decode(MarvelResponse<Character>.self, from: data)
                    let characters = marvelResponse.data?.results ?? []
                    let uniqueNewCharacters = characters.filter { newCharacter in
                        !(self.characters.contains { $0.id == newCharacter.id })
                    }
                    self.characters.append(contentsOf: uniqueNewCharacters)
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
