//
//  ContentView.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 28/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world 5!")
                .font(.custom("BentonSans Comp Black", size: 30))
            
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
