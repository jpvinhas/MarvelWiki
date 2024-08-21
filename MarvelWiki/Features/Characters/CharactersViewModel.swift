//
//  CharactersViewModel.swift
//  MarvelWiki
//
//  Created by Ricardo Silva Vale on 04/07/24.
//

import Foundation
import SwiftUI

class CharactersViewModel: ObservableObject {
    
    static let shared = CharactersViewModel()
    
    @Published var characters : [Character] = []
    @Published var character : Character?
    @Published var nameStartsWithCharacters: [Character] = []
    @Published var searchCharacter: [Character] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var isInitLoading: Bool = true
    
    private var canLoadMorePages = true
    private var currentPage = 0
    private let itemsPerPage = 20
    private var errorMessage: String?
    private let apiService = ApiServiceCharacter.singleton
    
    let notLoad = [
        "http://i.annihil.us/u/prod/marvel/i/mg/f/60/4c002e0305708",
        "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
    ]
    
    @Published var isSearchingCharacter: Bool = false {
        didSet {
            if !self.searchText.isEmpty && self.isSearchingCharacter{
                self.fetchCharactersByName()
            }else {
                self.searchCharacter.removeAll()
            }
        }
    }
    
    @Published var search: Bool = false {
        didSet {
            if !self.searchText.isEmpty {
                print("load")
                self.fetchCharactersByName()
            }else{
                print("no text")
                self.searchCharacter.removeAll()
            }
        }
    }
    
    
    private init() {
        DispatchQueue.main.async {
            self.fetchCharacters()
            self.fetchCharactersByName()
        }
    }
    
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func fetchCharacters() {
        guard !self.isLoading && self.canLoadMorePages else {return}
        self.isLoading = true
        self.errorMessage = nil
        
        apiService.getCharacters(page: currentPage){ [weak self] characters in
            DispatchQueue.main.async {
                if !characters.isEmpty{
                    self?.characters.append(contentsOf: characters)
                    self?.currentPage += 1
                } else {
                    self?.canLoadMorePages = false
                }
                self?.isLoading = false
                if(self!.isInitLoading){
                    self?.isInitLoading.toggle()
                }
                print("ok!")
            }
        }
    }
    
    func fetchMoreCharacters(){
        self.fetchCharacters()
    }
    
    func fetchCharacter(id: Int) {
        self.isLoading = true
        self.errorMessage = nil
        
        apiService.getCharacterId(characterId: id) { [weak self] character in
            DispatchQueue.main.async {
                self?.character = character
                self?.isLoading = false
            }
        }
    }
    
    func fetchCharactersByName(){
        guard !searchText.isEmpty else {
            self.searchCharacter = []
            self.isLoading = false
            return
        }
        print("feching characters by name")
        
        self.isLoading = true
        self.errorMessage = nil
        
        apiService.fecthCharacterName(characterName: self.searchText) { [weak self]  nameStartsWithResponse in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if let nameStartsWithResponse = nameStartsWithResponse {
                    self.searchCharacter = self.filteredCharacters(characters: nameStartsWithResponse)
                } else{
                    self.searchCharacter = []
                    self.errorMessage = "personagem não encontrado"
                }
                self.isLoading = false
            }
        }
    }
    
    private func filteredCharacters(characters: [Character]) -> [Character] {
        return characters.filter { character in
            let url = "\(character.thumbnail.path)/portrait_medium.\(character.thumbnail.ext)"
            return !notLoad.contains(where: { url.contains($0) })
        }
    }
    
    func getFilteredCharacters() -> [Character] {
        return filteredCharacters(characters: characters)
    }
    
    
}
