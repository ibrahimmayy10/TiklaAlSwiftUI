//
//  BasketViewModel.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 21.02.2024.
//

import Foundation
import Firebase

class BasketViewModel: ObservableObject {
    
    @Published var products = [BasketProductModel]()
    
    func getDataBasket() {
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        
        let firestore = Firestore.firestore()
        
        firestore.collection("Basket").whereField("postedBy", isEqualTo: currentUserID).getDocuments { snapshot, error in
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
                          let images = document.get("images") as? [String],
                          let piece = document.get("piece") as? Int else { return }
                    
                    let products = BasketProductModel(id: id, title: title, thumbnail: imageUrl, price: price, description: description, discountPercentage: discountPercentage, rating: rating, images: images, piece: piece)
                    self.products.append(products)
                }
            }
        }
    }
    
    func calculateTotalPrice() -> Double {
        var totalPrice = 0.0
        for product in products {
            totalPrice += Double(product.price) * Double(product.piece ?? 1)
        }
        return totalPrice
    }
    
    func increasePiece(for product: BasketProductModel) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            guard var piece = products[index].piece else { return }
            piece += 1
            products[index].piece = piece
            updatePieceInDatabase(for: products[index])
        }
    }
    
    func decreasePiece(for product: BasketProductModel) {
        if let index = products.firstIndex(where: { $0.id == product.id }), products[index].piece ?? 2 > 1 {
            guard var piece = products[index].piece else { return }
            piece -= 1
            products[index].piece = piece
            updatePieceInDatabase(for: products[index])
        }
    }
    
    func updatePieceInDatabase(for product: BasketProductModel) {
        let firestore = Firestore.firestore()
        
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            firestore.collection("Basket").whereField("id", isEqualTo: products[index].id).getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else if let documents = snapshot?.documents.first {
                    let documentID = documents.documentID
                    firestore.collection("Basket").document(documentID).updateData(["piece": product.piece as Any]) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("Güncelleme işlemi başarılı")
                        }
                    }
                }
            }
        }
    }
    
    func confirmBasket(totalPrice: Double, completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(false)
            return
        }
        let currentUserID = user.uid
        
        let firestore = Firestore.firestore()
        
        var orderedProdutcs = [[String: Any]]()
        for product in products {
            let productData = ["id": product.id,
                               "title": product.title,
                               "description": product.description,
                               "discountPercentage": product.discountPercentage,
                               "rating": product.rating,
                               "price": product.price, 
                               "images": product.images,
                               "thumbnail": product.thumbnail,
                               "piece": product.piece ?? 1] as [String: Any]
            
            orderedProdutcs.append(productData)
        }
        
        let orderData = ["orderedBy": currentUserID,
                         "orderedProducts": orderedProdutcs,
                         "totalPrice": totalPrice, 
                         "time": Timestamp(date: Date())] as [String: Any]
        
        firestore.collection("Orders").addDocument(data: orderData) { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(false)
            } else {
                print("sepet onaylandı")
                completion(true)
            }
        }
        
        firestore.collection("Basket").whereField("postedBy", isEqualTo: currentUserID).getDocuments { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(false)
            } else if let documents = snapshot?.documents, !documents.isEmpty {
                for document in documents {
                    let documentID = document.documentID
                    
                    firestore.collection("Basket").document(documentID).delete { error in
                        if let error = error {
                            print(error.localizedDescription)
                            completion(false)
                        } else {
                            print("sepet temizlendi")
                            completion(true)
                        }
                    }
                }
                completion(true)
            }
        }
    }
    
    func removeBasket(product: BasketProductModel) {
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        
        let firestore = Firestore.firestore()
        
        firestore.collection("Basket").whereField("postedBy", isEqualTo: currentUserID).whereField("title", isEqualTo: product.title).getDocuments { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else if let documents = snapshot?.documents, !documents.isEmpty {
                for document in documents {
                    let documentID = document.documentID
                    
                    firestore.collection("Basket").document(documentID).delete { error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("ürün silindi")
                        }
                    }
                }
            }
        }
    }

}
