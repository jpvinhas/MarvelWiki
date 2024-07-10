//
//  SearchViewModel.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 10/07/24.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchComics: [Comic]? = []
    var searchOffset = 0
    let limit = 20
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var total: Int = 0
    @Published var isSearchingComic: Bool = false {
        didSet {
            if self.searchText.count != 0 {
                self.loadSearchComics()
            }else {
                self.searchComics?.removeAll()
            }
        }
    }
    @Published var search: Bool = false {
        didSet {
            if self.searchText.count != 0 {
                self.searchComics?.removeAll()
                self.loadSearchComics()
            }else{
                print("no text")
                self.searchComics?.removeAll()
            }
        }
    }
    private let apiService = ApiServiceComic.singleton
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36)
    ]
    func loadSearchComics() {
        isLoading = true
        
        apiService.getComicsByName(tileStartsWith: self.searchText,offset: searchOffset) { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let marvelResponse = try decoder.decode(MarvelResponse<Comic>.self, from: data)
                    self.searchComics?.append(contentsOf: marvelResponse.data?.results ?? [])
                    self.total = marvelResponse.data?.total ?? 0
                    self.searchOffset += self.limit
                    self.isLoading = false
                } catch {
                    print("Erro ao decodificar JSON:", error.localizedDescription)
                    self.searchComics = []
                }
            }
        }
    }
}
