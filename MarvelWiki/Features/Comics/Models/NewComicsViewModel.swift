//
//  NewComicsViewModel.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 11/07/24.
//

import Foundation

@Observable
class NewComicsViewModel: ComicsModel {
    
    static let shared = NewComicsViewModel()
    private let apiService = ApiServiceComic.singleton

    var comics: [Comic] = []
    var isLoading: Bool = false
    var available: Int = 0
    internal var offset = 0
    internal var limit = 10
    
    init() {
        print("iniciando new viewmodel")
        self.loadComics()
    }
    
    func loadComics() {
        isLoading = true
        
        apiService.getComicsByYear(startYear: 2024, offset: offset) { [weak self] data in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let marvelResponse = try decoder.decode(MarvelResponse<Comic>.self, from: data)
                    let newComics = marvelResponse.data?.results ?? []
                    let uniqueNewComics = newComics.filter { newComic in
                        !(self.comics.contains { $0.id == newComic.id })
                    }
                    self.comics.append(contentsOf: uniqueNewComics)
                    let total = marvelResponse.data?.total ?? 0
                    self.available = total == 0 ? -1 : total
                    self.offset += self.limit
                    self.isLoading = false
                } catch {
                    print("Erro ao decodificar JSON:", error.localizedDescription)
                }
            }
        }
    }
}
