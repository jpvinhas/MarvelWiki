//
//  HomeView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct HomeView: View {
    
    //@State private var marvelResponse: MarvelResponse<Comic>?
    @State var searchText = ""
    @State var searchs = false
    @State var search = false

    var ext = "jpg"
    var size = "portrait_medium"
    @StateObject private var homeViewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            VStack{
                Image("MWhorizontal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 230, height: 62)
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
                                .frame(maxWidth: .infinity)
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

