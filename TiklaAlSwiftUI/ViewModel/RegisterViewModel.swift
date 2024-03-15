//
//  RegisterViewModel.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 14.02.2024.
//

import Foundation
import Firebase

class RegisterViewModel: ObservableObject {
    @Published var email = String()
    @Published var password = String()
    @Published var name = String()
    @Published var errorMessage = String()
    
    init() {
        
    }
    
    func register(completion: @escaping (Bool) -> Void) {
        guard validate() else {
            completion(false)
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authData, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let firestore = Firestore.firestore()
                
                guard let user = Auth.auth().currentUser else { return }
                let currentUserID = user.uid
                
                let userFirestore = ["postedBy": currentUserID, "name": self.name]
                
                firestore.collection("Users").document(authData?.user.uid ?? "").setData(userFirestore) { fatalError in
                    if let error = fatalError {
                        print(error.localizedDescription)
                        completion(false)
                    } else {
                        print("kayıt işlemi başarılı")
                        completion(true)
                    }
                }
            }
        }
    }
    
    func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurunuz"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Lütfen geçerli bir email adresi giriniz"
            return false
        }
        
        return true
    }
}
