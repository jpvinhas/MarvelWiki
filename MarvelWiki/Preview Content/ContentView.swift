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
            ApiService.singleton.getHomeJson { responseHome in
                DispatchQueue.main.async {
                    //print(responseHome.header.primaryLinks)
                    //responseHome.header.primaryLinks
                    for primaryLink in responseHome.header.primaryLinks{
                        if primaryLink.title == "Comics"{
                            for cardImage in primaryLink.content{
                                print(cardImage.image.filename)
                                //AsyncImage(url: URL(string: cardImage.image.filename) )
                            }
                        }
                        
                    }
                }
            }
        })
        .padding()
    }
    
}


#Preview {
    ContentView()
}
