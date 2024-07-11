//
//  CharactersViewModel.swift
//  MarvelWiki
//
//  Created by Ricardo Silva Vale on 04/07/24.
//

import Foundation
import SwiftUI

class CharactersViewModel: ObservableObject {
    
    @Published var characters : [Character] = []
    @Published var character : Character?
    @Published var nameStartsWithCharacters: [Character] = []
    @Published var searchCharacter: [Character]?
    @Published var searchText: String = ""
    @Published var isLoading = false
    
    private var canLoadMorePages = true
    private var currentPage = 0
    private let itemsPerPage = 20
    private var errorMessage: String?
    private let apiService = ApiServiceCharacter.singleton
    
    @Published var isSearchingCharacter: Bool = false{
        didSet {
            if self.searchText.count != 0 {
                self.fetchCharactersByName()
            }else {
                self.searchCharacter?.removeAll()
                self.searchCharacter = nil
            }
        }
    }
    
    @Published var search: Bool = false {
        didSet {
            if self.searchText.count != 0 {
                print("load")
                self.fetchCharactersByName()
            }else{
                print("no text")
                self.searchCharacter?.removeAll()
                self.searchCharacter = nil
            }
        }
    }
    
    
    init() {
        self.searchCharacter = nil
        DispatchQueue.main.async {
            self.fetchCharacters()
            self.fetchCharactersByName()
            
        }
    }
    
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36)
    ]
    
    func fetchCharacters() {
        guard !isLoading && canLoadMorePages else {return}
        isLoading = true
        errorMessage = nil
        
        apiService.getCharacters(page: currentPage){ [weak self] characters in
            DispatchQueue.main.async {
                if !characters.isEmpty{
                    self?.characters.append(contentsOf: characters)
                    self?.currentPage += 1
                } else {
                    self?.canLoadMorePages = false
                }
                self?.isLoading = false
            }
        }
    }
    
    func fetchMoreCharacters(){
        fetchCharacters()
    }
    
    func fetchCharacter(id: Int) {
        isLoading = true
        errorMessage = nil
        
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
        
        isLoading = true
        errorMessage = nil
        
        apiService.fecthCharacterName(characterName: self.searchText) { [weak self]  nameStartsWithResponse in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if let nameStartsWithResponse = nameStartsWithResponse {
                    self.searchCharacter = nameStartsWithResponse
                } else{
                    self.searchCharacter = []
                    self.errorMessage = "personagem não encontrado"
                }
                self.isLoading = false
            }
        }
    }
    
}
