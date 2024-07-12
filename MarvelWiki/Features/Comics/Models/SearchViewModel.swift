//
//  SearchViewModel.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 10/07/24.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject, ComicsModel {
    
    private let apiService = ApiServiceComic.singleton
    
    @Published var comics: [Comic] = []
    @Published var isLoading: Bool = false
    @Published var available: Int = 0
    internal var offset = 0
    internal let limit = 20
    @Published var searchText: String = ""
    
    @Published var isSearchingComic: Bool = false {
        didSet {
            if self.searchText.count != 0 && self.isSearchingComic {
                self.comics.removeAll()
                self.loadComics()
            }else {
                self.comics.removeAll()
            }
        }
    }
    @Published var search: Bool = false {
        didSet {
            if self.searchText.count != 0 {
                self.comics.removeAll()
                self.loadComics()
            }else{
                print("no text")
                self.comics.removeAll()
            }
        }
    }
    func loadComics() {
        isLoading = true
        
        apiService.getComicsByName(tileStartsWith: self.searchText,offset: offset) { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let marvelResponse = try decoder.decode(MarvelResponse<Comic>.self, from: data)
                    self.comics.append(contentsOf: marvelResponse.data?.results ?? [])
                    
                    let total = marvelResponse.data?.total ?? 0
                    self.available = total == 0 ? -1 : total
                    self.offset += self.limit
                    self.isLoading = false
                } catch {
                    print("Erro ao decodificar JSON:", error.localizedDescription)
                    self.comics = []
                    self.isLoading = false
                    self.available = -1
                }
            }
        }
    }
}
