//
//  DetailsViewModel.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 19.02.2024.
//

import Foundation
import Firebase

class DetailsViewModel: ObservableObject {
    
    @Published var favoriteProducts = [Products]()
    
    func addBasket(product: Any) {
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        
        let firestore = Firestore.firestore()
        
        if let product = product as? Products {
            let basketProducts = ["postedBy": currentUserID,
                                  "id": product.id, 
                                  "title": product.title,
                                  "description": product.description,
                                  "discountPercentage": product.discountPercentage,
                                  "rating": product.rating, 
                                  "price": product.price,
                                  "images": product.images,
                                  "thumbnail": product.thumbnail ?? "",
                                  "piece": 1] as [String: Any]
            
            firestore.collection("Basket").addDocument(data: basketProducts) { error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    print("Sepete eklendi")
                }
            }
        } else if let product = product as? BasketProductModel {
            let basketProducts = ["postedBy": currentUserID,
                                  "id": product.id, 
                                  "title": product.title,
                                  "description": product.description,
                                  "discountPercentage": product.discountPercentage,
                                  "rating": product.rating, 
                                  "price": product.price,
                                  "images": product.images,
                                  "thumbnail": product.thumbnail,
                                  "piece": 1] as [String: Any]
            
            firestore.collection("Basket").addDocument(data: basketProducts) { error in
                if error != nil {
                    print("HATAAA: \(error?.localizedDescription ?? "")")
                } else {
                    print("Sepete eklendi")
                }
            }
        }
    }
    
    func addFavorite(product: Products) {
        favoriteProducts.append(product)
        
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        
        let firestore = Firestore.firestore()
        
        let favoriteProducts = ["postedBy": currentUserID, 
                                "id": product.id,
                                "title": product.title,
                                "description": product.description,
                                "discountPercentage": product.discountPercentage,
                                "rating": product.rating,
                                "price": product.price,
                                "category": product.category,
                                "images": product.images,
                                "thumbnail": product.thumbnail ?? ""] as [String: Any]
        
        firestore.collection("Favorite").addDocument(data: favoriteProducts) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("favorilere eklendi")
            }
        }
    }
    
    func isFavorite(product: Products) -> Bool {
        return favoriteProducts.contains(where: { $0.id == product.id })
    }
    
}
