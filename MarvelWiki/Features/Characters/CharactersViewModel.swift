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
    
    
    private var currentPage = 0
    private var isLoading = false
    private var errorMessage: String?
    private let apiService = ApiServiceCharacter.singleton
    
    init() {
            fetchCharacters()
        }
        
        func fetchCharacters() {
            isLoading = true
            errorMessage = nil
            
            ApiServiceCharacter.singleton.getCharacters { [weak self] characters in
                DispatchQueue.main.async {
                    self?.characters = characters
                    self?.isLoading = false
                }
            }
        }
    
    func fetchCharacter(by id: Int) {
            isLoading = true
            errorMessage = nil
            
            ApiServiceCharacter.singleton.getCharacterId(characterId: id) { [weak self] character in
                DispatchQueue.main.async {
                    self?.character = character
                    self?.isLoading = false
                }
            }
        }
    
}
    
