//
//  CarroselView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 03/07/24.
//

import SwiftUI

struct CarroselView: View {
    
    @StateObject var carroselViewModel: CarroselViewModel = CarroselViewModel()
    
    var body: some View {
        VStack(alignment: .center){
            
            CarroselBox(carroselViewModel: carroselViewModel)
            
            HStack{
                ForEach(0..<carroselViewModel.items.count, id: \.self) { index in
                    Circle()
                        .fill(carroselViewModel.currentIndex == index ? Color("mClearGray") : Color("nightgray"))
                        .frame(width: 9, height: 9)
                        .animation(.default, value: carroselViewModel.currentIndex)
                }
                
            }.padding(.top,0)
        }
        .onAppear{
            carroselViewModel.startTimer()
        }
        .onDisappear{
            carroselViewModel.timer?.invalidate()
        }
    }
}

#Preview {
    CarroselView()
}
