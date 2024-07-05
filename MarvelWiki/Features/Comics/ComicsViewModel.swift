//
//  ComicsViewModel.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 03/07/24.
//

import Foundation

class ComicsViewModel: ObservableObject {
    
    @Published var carroselComics : [Comic] = []
    @Published var comics: [Comic]?
    
    private let apiService = ApiServiceComic.singleton
    
    init() {
        DispatchQueue.main.async {
            self.loadComics()
        }
    }
    
    func loadComics() {
        apiService.getComics { [weak self] data in
            guard let self = self else { return }
            
            do {
                let decoder = JSONDecoder()
                let marvelResponse = try decoder.decode(MarvelResponse<Comic>.self, from: data)
                comics = marvelResponse.data?.results ?? []
        
            } catch {
                print("Erro ao decodificar JSON:", error.localizedDescription)
            }
        }
    }
}
