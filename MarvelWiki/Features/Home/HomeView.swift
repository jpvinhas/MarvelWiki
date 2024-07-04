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
    @State private var scrollID: Int?

    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    if !homeViewModel.primaryLinks.isEmpty{
                        ForEach(homeViewModel.primaryLinks){ primaryLink in
                            VStack{
                                if primaryLink.title == "News"{
                                    Text(primaryLink.title)
                                        .font(.custom("BentonSans Comp Black", size: 28))
                                        .padding(.top)
                                    ScrollView(.horizontal, showsIndicators: false){
                                        LazyHStack(spacing: 0){
                                            ForEach(0..<primaryLink.content.count, id: \.self){ index in
                                                
                                                HStack{
                                                    
                                                    let card1 = primaryLink.content[index]
                                                    
                                                    VStack{
                                                        
                                                        if let url = URL(string: "https://cdn.marvel.com/content/1x/" + card1.image.filename) {
                                                            AsyncImage(url: url){ image in
                                                                image
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(maxWidth: 340)
                                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                                                    .shadow(radius: 10)
                                                                    .padding(4)
                                                            } placeholder: {
                                                                ProgressView()
                                                            }.onAppear()
                                                        }else{
                                                            ProgressView("Loading...")
                                                                .navigationTitle("Loading")
                                                        }
                                                        Text(card1.headline)
                                                            .font(.custom("BentonSans Comp Black", size: 16))
                                                            .frame(width: 300)
                                                    }
                                                    
                                                }.containerRelativeFrame(.horizontal)
                                                    .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                                        content
                                                            .opacity(phase.isIdentity ? 1.0 : 0.6)
                                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                                                    }
                                            }
                                        }.scrollTargetLayout()
                                    }
                                    .scrollPosition(id: $scrollID)
                                    .scrollTargetBehavior(.paging)
                                    .frame(height: 270)
                                    IndicatorView(imageCount: primaryLink.content.count, scrollID: $scrollID)
                                }
                            }
                            VStack{
                                if primaryLink.title == "Comics"{
                                    Text("Latest " + primaryLink.title)
                                        .font(.custom("BentonSans Comp Black", size: 24))
                                        .padding(.top)
                                    ScrollView(.horizontal, showsIndicators: false){
                                        LazyHStack(spacing: 0){
                                            ForEach(0..<primaryLink.content.count/3, id: \.self){ index in
                                                
                                                HStack{
                                                    ForEach(0..<3) { subIndex in
                                                        let card1 = primaryLink.content[index * 3 + subIndex]
                                                                                    
                                                        VStack{
                                                            
                                                            if let url = URL(string: card1.image.filename) {
                                                                AsyncImage(url: url){ image in
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                        .shadow(radius: 10)
                                                                        .padding(4)
                                                                } placeholder: {
                                                                    ProgressView()
                                                                }
                                                            }else{
                                                                ProgressView("Loading...")
                                                                    .navigationTitle("Loading")
                                                            }
                                                            Text(card1.headline)
                                                                .font(.custom("BentonSans Comp Black", size: 14))
                                                                .frame(width: 100)
                                                        }
                                                    }
                                                }.containerRelativeFrame(.horizontal)
                                                .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                                    content
                                                        .opacity(phase.isIdentity ? 1.0 : 0.6)
                                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                                                }
                                                
                                            }
                                        }.scrollTargetLayout()
                                    }
                                    //.scrollPosition(id: $scrollID)
                                    .scrollTargetBehavior(.paging)
                                    .frame(height: 230)
                                    //IndicatorView(imageCount: primaryLink.content.count, scrollID: $scrollID)
                                }
                                VStack{
                                    if primaryLink.title == "Characters"{
                                        Text(primaryLink.title)
                                            .font(.custom("BentonSans Comp Black", size: 24))
                                            .padding(.top)
                                        ScrollView(.horizontal, showsIndicators: false){
                                            LazyHStack(spacing: 0){
                                                ForEach(0..<primaryLink.content.count/3, id: \.self){ index in
                                                    HStack{
                                                        ForEach(0..<3) { subIndex in
                                                            let card1 = primaryLink.content[index * 3 + subIndex]
                                                            
                                                            VStack{
                                                                
                                                                if let url = URL(string: "https://cdn.marvel.com/content/1x/" + card1.image.filename) {
                                                                    AsyncImage(url: url){ image in
                                                                        image
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                            .shadow(radius: 10)
                                                                            .padding(4)
                                                                    } placeholder: {
                                                                        ProgressView()
                                                                    }
                                                                }else{
                                                                    ProgressView("Loading...")
                                                                        .navigationTitle("Loading")
                                                                }
                                                                Text(card1.headline)
                                                                    .font(.custom("BentonSans Comp Black", size: 16))
                                                                    .frame(width: 100)
                                                            }
                                                        }
                                                    }.containerRelativeFrame(.horizontal)
                                                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                                            content
                                                                .opacity(phase.isIdentity ? 1.0 : 0.6)
                                                                .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                                                        }
                                                    
                                                }
                                            }.scrollTargetLayout()
                                        }
                                        //.scrollPosition(id: $scrollID)
                                        .scrollTargetBehavior(.paging)
                                        .frame(height: 165)
                                        //IndicatorView(imageCount: primaryLink.content.count, scrollID: $scrollID)
                                    }
                                    VStack{
                                        if primaryLink.title == "Movies"{
                                            Text(primaryLink.title)
                                                .font(.custom("BentonSans Comp Black", size: 24))
                                                .padding(.top)
                                            ScrollView(.horizontal, showsIndicators: false){
                                                LazyHStack(spacing: 0){
                                                    ForEach(0..<primaryLink.content.count/3, id: \.self){ index in
                                                        
                                                        HStack{
                                                            ForEach(0..<3) { subIndex in
                                                                let card1 = primaryLink.content[index * 3 + subIndex]
                                                                
                                                                VStack{
                                                                    
                                                                    if let url = URL(string: "https://cdn.marvel.com/content/1x/" + card1.image.filename) {
                                                                        AsyncImage(url: url){ image in
                                                                            image
                                                                                .resizable()
                                                                                .scaledToFit()
                                                                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                                .shadow(radius: 10)
                                                                                .padding(4)
                                                                        } placeholder: {
                                                                            ProgressView()
                                                                        }
                                                                    }else{
                                                                        ProgressView("Loading...")
                                                                            .navigationTitle("Loading")
                                                                    }
                                                                    Text(card1.headline)
                                                                        .font(.custom("BentonSans Comp Black", size: 16))
                                                                        .frame(width: 100)
                                                                }
                                                            }
                                                        }.containerRelativeFrame(.horizontal)
                                                            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                                                content
                                                                    .opacity(phase.isIdentity ? 1.0 : 0.6)
                                                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                                                            }
                                                        
                                                    }
                                                }.scrollTargetLayout()
                                            }
                                            //.scrollPosition(id: $scrollID)
                                            .scrollTargetBehavior(.paging)
                                            .frame(height: 220)
                                            //IndicatorView(imageCount: primaryLink.content.count, scrollID: $scrollID)
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    else{
                        ProgressView("Loading...")
                            .navigationTitle("Loading")
                    }
                }
            }
            
        }
    }
    
}

#Preview {
    HomeView()
}


struct IndicatorView: View {
    let imageCount: Int
    @Binding var scrollID: Int?
    var body: some View {
        HStack {
            ForEach(0..<imageCount, id: \.self) { indicator in
            let index = scrollID ?? 0
                Button {
                    withAnimation {
                        scrollID = indicator
                    }
                } label: {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundStyle(indicator == index ? Color.gray : Color(.lightGray))
                }
            }
        }
        .padding(.bottom)
        //.background(RoundedRectangle(cornerRadius: 10).fill(Color(.lightGray)).opacity(0.2))
    }
}
