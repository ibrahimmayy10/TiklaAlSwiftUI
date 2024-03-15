//
//  TiklaAlSwiftUIApp.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 13.02.2024.
//

import SwiftUI
import FirebaseCore

@main
struct TiklaAlSwiftUIApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
