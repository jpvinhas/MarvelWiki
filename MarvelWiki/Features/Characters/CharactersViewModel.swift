//
//  CharactersViewModel.swift
//  MarvelWiki
//
//  Created by Ricardo Silva Vale on 04/07/24.
//
import Combine
import Foundation

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
    
    init() {
        fetchCharacters()
    }
    
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
     
    func fetchCharacter(by id: Int) {
        isLoading = true
        errorMessage = nil
        
        apiService.getCharacterId(characterId: id) { [weak self] character in
            DispatchQueue.main.async {
                self?.character = character
                self?.isLoading = false
            }
        }
    }
    func fetchCharactersByName(by name: String){
        isLoading = true
        errorMessage = nil
        
        apiService.fecthCharacterName(characterName: name) { [weak self]  nameStartsWithResponse in
            DispatchQueue.main.async{
                self?.nameStartsWithCharacters =  nameStartsWithResponse ?? []
                self?.isLoading = false
                
            }
        }
    }
    
}
