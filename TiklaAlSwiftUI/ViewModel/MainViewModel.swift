//
//  MainViewModel.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 14.02.2024.
//

import Foundation

var design = [
    Design(image: "apple"),
    Design(image: "pullbear"),
    Design(image: "xiaomi"),
    Design(image: "nike"),
    Design(image: "adidas")
]

class MainViewModel: ObservableObject {
    @Published private var currentIndex = 0
    private var timer: Timer?

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            self.currentIndex = (self.currentIndex + 1) % design.count
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }

}
