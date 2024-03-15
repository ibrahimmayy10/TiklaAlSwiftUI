//
//  AccountViewModel.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 7.03.2024.
//

import Foundation
import Firebase

class AccountViewModel: ObservableObject {
    
    @Published var name = String()
    @Published var email = String()
    
    @Published var orders = [OrderModel]()
    
    @Published var totalPrice = Double()
    
    @Published var productPiece = Int()
    @Published var time = Timestamp()
    
    func getDataUser() {
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        
        email = user.email ?? ""
        
        let firestore = Firestore.firestore()
        
        firestore.collection("Users").whereField("postedBy", isEqualTo: currentUserID).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let documents = snapshot?.documents, !documents.isEmpty {
                for document in documents {
                    guard let name = document.get("name") as? String else { return }
                    self.name = name
                }
            }
        }
    }
    
    func getDataOrder() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        let currentUserID = user.uid
        
        let firestore = Firestore.firestore()
        
        firestore.collection("Orders").whereField("orderedBy", isEqualTo: currentUserID).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let documents = snapshot?.documents, !documents.isEmpty {
                self.orders.removeAll()
                for document in documents {
                    if let productsData = document.get("orderedProducts") as? [[String: Any]],
                       let totalPrice = document.get("totalPrice") as? Double,
                       let time = document.get("time") as? Timestamp {
                        self.productPiece = productsData.count
                        
                        for productData in productsData {
                            guard let id = productData["id"] as? Int,
                                  let title = productData["title"] as? String,
                                  let thumbnail = productData["thumbnail"] as? String,
                                  let price = productData["price"] as? Int else { return }
                            
                            let product = OrderModel(id: id, title: title, thumbnail: thumbnail, price: price, time: time, totalPrice: totalPrice, piece: self.productPiece)
                            self.orders.append(product)
                        }
                    } else {
                        print("HATA1")
                    }
                }
            } else {
                print("HATA2")
            }
        }
    }
    
    func signOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            completion(false)
        }
    }
}
