//
//  Webservices.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 14.02.2024.
//

import Foundation

class Webservices {
    func downloadProductsContinuation(url: URL) async throws -> [Products] {
        try await withCheckedThrowingContinuation { continuation in
            downloadProducts(url: url) { products in
                continuation.resume(returning: products ?? [])
            }
        }
    }
    
    func downloadProducts(url: URL, completion: @escaping ([Products]?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            let response = try? JSONDecoder().decode(ProductModel.self, from: data)
            completion(response?.products)
        }.resume()
    }
}
