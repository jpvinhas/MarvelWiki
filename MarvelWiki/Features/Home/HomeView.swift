//
//  HomeView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct HomeView: View {
    
    var ext = "jpg"
    var size = "portrait_medium"
    @StateObject private var homeViewModel = HomeViewModel()
  

    var body: some View {
        NavigationStack {
            VStack{
                MarvelWikiSearchBar()
                ScrollView{
                    VStack{
                        if !homeViewModel.primaryLinks.isEmpty{
                            ForEach(homeViewModel.primaryLinks){ primaryLink in
                                if primaryLink.title == "News"{
                                    CarouselHome(primaryLink: primaryLink)
                                }
                                if primaryLink.title == "Comics"{
                                    CarouselElementsHome(primaryLink: primaryLink, withBaseUrl: false, withTitles: false)
                                }
                                if primaryLink.title == "Characters"{
                                    CarouselElementsHome(primaryLink: primaryLink, withBaseUrl: true, withTitles: true)
                                }
                            }
                            
                        }
                        else{
                            ProgressView("Loading...")
                                .navigationTitle("Loading")
                        }
                    }
                }
            }.background(Color("mBackground"))
        }
    }
    
}

#Preview {
    HomeView()
}

