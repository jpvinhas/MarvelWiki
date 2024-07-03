//
//  HomeView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var marvelResponse: MarvelResponse?
    var ext = "jpg"
    var size = "portrait_medium"
    
    var body: some View {
        NavigationView {
            VStack{
                MarvelWikiSearchBar()
                    .padding(.top,0)
                Spacer()
                if let marvelResponse = marvelResponse {
                    List(marvelResponse.data.results) { character in
                        HStack{
                            if let url = URL(string: "\(character.thumbnail.path)/\(size).\(ext)") {
                                AsyncImage(url: url)
                            }
                            Text(character.name)
                        }
                    }
                    .background(Color.clear)
                } else {
                    ProgressView("Loading...")
                        .onAppear {
                            loadMarvelResponse()
                        }
                        .navigationTitle("Loading")
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color("mBackground"))
        }.onAppear(perform: {
            loadMarvelResponse()
        })
    }
    func loadJSON(filename: String) -> MarvelResponse? {
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Couldn't find \(filename) in main bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: file)
            let decoder = JSONDecoder()
            return try decoder.decode(MarvelResponse.self, from: data)
        } catch {
            print("Error loading or decoding JSON: \(error)")
            return nil
        }
    }
    private func loadMarvelResponse() {
       marvelResponse = loadJSON(filename: "charactersReq")
   }
}

#Preview {
    HomeView()
}
