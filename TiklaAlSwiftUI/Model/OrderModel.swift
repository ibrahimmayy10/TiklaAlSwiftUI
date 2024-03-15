//
//  OrderProductsModel.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 8.03.2024.
//

import Foundation
import FirebaseFirestoreInternal

struct OrderModel {
    var id: Int
    var title: String
    var thumbnail: String
    var price: Int
    var time: Timestamp
    var totalPrice: Double
    var piece: Int
}
