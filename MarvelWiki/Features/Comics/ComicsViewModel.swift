//
//  ComicsViewModel.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 03/07/24.
//

import Foundation
import SwiftUI

class ComicsViewModel: ObservableObject {
    
    @Published var comics: [Comic]?
    @Published var newComics: [Comic]?
    var newOffset = 0
    var allOffset = 0
    let limit = 20
    var reqlimited = false
    
    private let apiService = ApiServiceComic.singleton
    
    init() {
        self.comics = []
        self.newComics = []
        DispatchQueue.main.async {
            self.loadComics()
            self.loadNewComics()
        }
    }
    
    func loadComics() {
        apiService.getComics(offset: allOffset){ [weak self] data in
            guard let self = self else { return }
            
            do {
                let decoder = JSONDecoder()
                let marvelResponse = try decoder.decode(MarvelResponse<Comic>.self, from: data)
                let newComics = marvelResponse.data?.results ?? []
                let uniqueNewComics = newComics.filter { newComic in
                    !(self.comics?.contains { $0.id == newComic.id } ?? false)
                }
                self.comics?.append(contentsOf: uniqueNewComics)
                allOffset += limit
            } catch {
                print("Erro ao decodificar JSON:", error.localizedDescription)
            }
        }
    }
    func loadNewComics() {
        apiService.getComicsByYear(startYear: 2024, offset: newOffset) { [weak self] data in
            guard let self = self else { return }
            
            do {
                let decoder = JSONDecoder()
                let marvelResponse = try decoder.decode(MarvelResponse<Comic>.self, from: data)
                self.newComics?.append(contentsOf: marvelResponse.data?.results ?? [])
                newOffset += limit
            } catch {
                print("Erro ao decodificar JSON:", error.localizedDescription)
            }
        }
    }
}
