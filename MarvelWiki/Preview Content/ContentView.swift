//
//  ContentView.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 28/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationView{
            
        }.onAppear(perform: {
            ApiServiceCharacter.singleton.getCharacters () { responseCharacter in
                DispatchQueue.main.async {
                    print(responseCharacter as Any)
                }
                
            }
        })
        .padding()
    }
    
}


#Preview {
    ContentView()
}
