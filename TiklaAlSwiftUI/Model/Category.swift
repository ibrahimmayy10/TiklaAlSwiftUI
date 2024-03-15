//
//  Category.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 14.02.2024.
//

import Foundation

struct Category: Identifiable {
    let id = UUID()
    let text: String
    let imageName: String
    let category: String
}

struct Design: Identifiable {
    let id = UUID()
    let image: String
}
