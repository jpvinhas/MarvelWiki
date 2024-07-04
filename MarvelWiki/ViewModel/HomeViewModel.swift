//
//  HomeViewModel.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 03/07/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var primaryLinks: [PrimaryLink]
    @Published var cards: [CardHome]
    
    init(){
        self.cards = []
        self.primaryLinks = []
        fetchResponseHome()
        getCardsHome()
        
    }
    
    func fetchResponseHome(){
        
        ApiService.singleton.getHomeJson{ primaryLinks in
            DispatchQueue.main.async {
                self.primaryLinks = primaryLinks
            }
        }
    }
    
    func getCardsHome() {
        for primaryLink in primaryLinks{
            //self.primaryLinks.append(primaryLink)
            for cardHome in primaryLink.content{
                self.cards.append(cardHome)
            }
        }
       
    }
    
}
