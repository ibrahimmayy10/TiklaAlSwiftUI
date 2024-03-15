//
//  FavoriteViewModel.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 29.02.2024.
//

import Foundation
import Firebase

class FavoriteViewModel: ObservableObject {
    @Published var products = [BasketProductModel]()
    var isDataLoaded: Bool = false
    
    func getDataFavorite() {
        guard !isDataLoaded else { return }
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        
        let firestore = Firestore.firestore()
        
        firestore.collection("Favorite").whereField("postedBy", isEqualTo: currentUserID).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let documents = snapshot?.documents, !documents.isEmpty {
                for document in documents {
                    guard let id = document.get("id") as? Int,
                          let title = document.get("title") as? String,
                          let imageUrl = document.get("thumbnail") as? String,
                          let price = document.get("price") as? Int,
                          let description = document.get("description") as? String,
                          let discountPercentage = document.get("discountPercentage") as? Double,
                          let rating = document.get("rating") as? Double,
                          let images = document.get("images") as? [String] else { return }
                          
                    let products = BasketProductModel(id: id, title: title, thumbnail: imageUrl, price: price, description: description, discountPercentage: discountPercentage, rating: rating, images: images)
                    
                    self.products.append(products)
                }
            }
        }
        isDataLoaded = true
    }
    
    func removeFavorite(product: BasketProductModel) {
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        
        let firestore = Firestore.firestore()
        
        firestore.collection("Favorite").whereField("postedBy", isEqualTo: currentUserID).whereField("title", isEqualTo: product.title).getDocuments { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else if let documents = snapshot?.documents, !documents.isEmpty {
                for document in documents {
                    let documentID = document.documentID
                    
                    firestore.collection("Favorite").document(documentID).delete { error in
                        if let error = error {
                            print(error)
                        } else {
                            print("favori kaldırıldı")
                            if let index = self.products.firstIndex(where: { $0.id == product.id }) {
                                self.products.remove(at: index)
                            }
                        }
                    }
                }
            }
        }
    }
}
