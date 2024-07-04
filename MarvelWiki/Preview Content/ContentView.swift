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
            
           
            VStack {
                
                if !homeViewModel.primaryLinks.isEmpty{
                    ForEach(homeViewModel.primaryLinks){ primaryLink in
                       
                        if primaryLink.title == "Comics"{
                            Text("Latest " + primaryLink.title)
                                .font(.custom("BentonSans Comp Black", size: 24))
                                .padding(.leading,25)
                                List(primaryLink.content){ card in
                                    if let url = URL(string: card.image.filename) {
                                        AsyncImage(url: url){ image in
                                            image
                                                .image?.resizable()
                                                .scaledToFit()
                                                .frame(width: 100)
                                                .cornerRadius(5.0)
                                        }
                                    }else{
                                        ProgressView("Loading...")
                                            .navigationTitle("Loading")
                                    }
                                    Text(card.headline)
                                        .font(.custom("BentonSans Comp Black", size: 14))
                                        .frame(width: 100)
                                        
                                }
                        }
                    }
                }else{
                    ProgressView("Loading...")
                        .navigationTitle("Loading")
                }
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world 5!")
                    .font(.custom("BentonSans Comp Black", size: 30))
                
            }
        }
        .padding()
    }
    
}


#Preview {
    ContentView()
}
