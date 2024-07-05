//
//  CarroselBox.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 04/07/24.
//

import SwiftUI

struct CarroselBox: View {
    
    @ObservedObject var carroselViewModel: CarroselViewModel

    var body: some View {
        ZStack{
            GeometryReader{ reader in
                HStack(spacing: 0){
                    ForEach(carroselViewModel.items, id: \.self) { item in
                        CarroselImageCard(image: item)
                            .frame(width: carroselViewModel.screenWidth)
                    }
                }
                .offset(x: carroselViewModel.xOffset)
                .animation(.easeInOut, value: carroselViewModel.xOffset)
                .gesture(
                    DragGesture()
                        .onChanged({value in
                            carroselViewModel.onChanged(value: value)
                            carroselViewModel.restartTimer()
                        })
                        .onEnded({ value in
                            carroselViewModel.onEnded(value: value)
                            carroselViewModel.restartTimer()
                        })
                )
            }
        }.frame(height: 190)
    }
}
struct CarroselImageCard: View {
    var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .frame(width: 340)
    }
}

