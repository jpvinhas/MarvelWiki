//
//  ComicsViewModel.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 03/07/24.
//

import Foundation
import SwiftUI

class ComicsViewModel: ObservableObject {
    
    @Published var comicById: Comic?
    @Published var searchComics: [Comic]?
    @Published var comics: [Comic]?
    @Published var newComics: [Comic]?
    @Published var searchText: String = ""
    @Published var idComic: Int = 13860 {
        didSet{
            if self.idComic != 0 {
                //self.loadComicById()
                //self.idComic = 0
            }
        }
    }
    @Published var isSearchingComic: Bool = false {
        didSet {
            if self.searchText.count != 0 {
                self.loadSearchComics()
            }else {
                self.searchComics?.removeAll()
                self.searchComics = nil
            }
        }
    }
    @Published var search: Bool = false {
        didSet {
            if self.searchText.count != 0 {
                print("load")
                self.loadSearchComics()
            }else{
                print("no text")
                self.searchComics?.removeAll()
                self.searchComics = nil
            }
        }
    }
    
    private let apiService = ApiServiceComic.singleton
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36)
    ]
    
    init() {
        self.searchComics = nil
        DispatchQueue.main.async {
            self.loadComics()
            self.loadComicsByYear()
            //self.loadComicById()
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
    func loadComicsByYear() {
        apiService.getComicsByYear(startYear: 2024) { [weak self] data in
            guard let self = self else { return }
            
            do {
                let decoder = JSONDecoder()
                let marvelResponse = try decoder.decode(MarvelResponse<Comic>.self, from: data)
                newComics = marvelResponse.data?.results ?? []
        
            } catch {
                print("Erro ao decodificar JSON:", error.localizedDescription)
            }
        }
    }
    func loadSearchComics() {
        apiService.getComicsByName(tileStartsWith: self.searchText) { [weak self] data in
            guard let self = self else { return }
            
            do {
                let decoder = JSONDecoder()
                let marvelResponse = try decoder.decode(MarvelResponse<Comic>.self, from: data)
                searchComics = marvelResponse.data?.results ?? []
        
            } catch {
                print("Erro ao decodificar JSON:", error.localizedDescription)
                searchComics = []
            }
        }
    }
    func loadComicById(id: Int) -> Comic?{
        apiService.getComicById(id: id){ [weak self] comic in
            guard let self = self else { return }
          
            comicById = comic.first
            print(comic.first ?? [])
            
        }
        return comicById ?? nil
    }
}
