//
//  CarroselViewModel.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 04/07/24.
//

import Foundation
import SwiftUI

class CarroselViewModel: ObservableObject {
    @Published var currentIndex = 0
    @Published var xOffset: CGFloat = 0
    @Published var timer: Timer? = nil
    var screenWidth = UIScreen.main.bounds.width
    var items = ["C1","C2","C3","C4","C5"]
    var lastPage = 4
    var firstPage = 0
    
    func onChanged(value: DragGesture.Value) {
        self.xOffset = value.translation.width - (screenWidth * CGFloat(currentIndex))
    }
        
    func onEnded(value: DragGesture.Value) {
        if -value.translation.width > screenWidth / 2 && self.currentIndex < lastPage {
            self.currentIndex += 1
        } else if value.translation.width > screenWidth / 2 && self.currentIndex > firstPage {
            self.currentIndex -= 1
        }
        withAnimation {
            self.xOffset = -screenWidth * CGFloat(self.currentIndex)
        }
    }
    func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation {
                if self.currentIndex + 1 == self.items.count {
                    self.currentIndex = 0
                } else {
                    self.currentIndex += 1
                }
            }
            self.xOffset = -self.screenWidth * CGFloat(self.currentIndex)
        }
    }
    
    func restartTimer() {
        self.timer?.invalidate()
        self.startTimer()
    }
}
