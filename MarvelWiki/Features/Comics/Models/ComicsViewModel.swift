//
//  ComicsViewModel.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 03/07/24.
//

import Foundation

class ComicsViewModel: ObservableObject,ComicsModel{
    
    private let apiService = ApiServiceComic.singleton
    
    @Published var comics: [Comic] = []
    @Published var isLoading: Bool = false
    @Published var available: Int = 0
    internal var offset = 0
    internal let limit = 20
    
    init() {
        print("iniciando comicviewmodel")
        self.loadComics()
    }
    
    func loadComics() {
        isLoading = true
        
        apiService.getComics(offset: offset){ [weak self] data in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let marvelResponse = try decoder.decode(MarvelResponse<Comic>.self, from: data)
                    let allComics = marvelResponse.data?.results ?? []
                    let uniqueAllComics = allComics.filter { newComic in
                        !(self.comics.contains { $0.id == newComic.id })
                    }
                    self.comics.append(contentsOf: uniqueAllComics)
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
