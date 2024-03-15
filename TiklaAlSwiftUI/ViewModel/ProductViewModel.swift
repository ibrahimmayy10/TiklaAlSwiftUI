//
//  ProductViewModel.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 14.02.2024.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var products = [Products]()
    
    func downloadProductsContinuation(url: URL) async {
        do {
            let products = try await Webservices().downloadProductsContinuation(url: url)
            self.products = products
        } catch {
            print(error.localizedDescription)
        }
    }
}
