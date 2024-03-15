//
//  BasketProductModel.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 21.02.2024.
//

import Foundation

struct BasketProductModel {
    var id: Int
    var title: String
    var thumbnail: String
    var price: Int
    var description: String
    var discountPercentage: Double
    var rating: Double
    var images: [String]
    var piece: Int?
}
