//
//  ButtonBarView.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 7.03.2024.
//

import SwiftUI

struct ButtonBarView: View {
    
    var currentView: CurrentView
    
    enum CurrentView {
        case home, favorites, basket, account
    }
    
    var body: some View {
        HStack {
            NavigationLink(destination: MainView()) {
                ButtonBarItem(systemName: currentView == .home ? "house.fill": "house", text: "Anasayfa", isHighlighted: currentView == .home)
            }
            
            Spacer()
            
            NavigationLink(destination: FavoriteView()) {
                ButtonBarItem(systemName: currentView == .favorites ? "star.fill": "star", text: "Favorilerim", isHighlighted: currentView == .favorites)
            }
            
            Spacer()
            
            NavigationLink(destination: BasketView()) {
                ButtonBarItem(systemName: currentView == .basket ? "cart.fill": "cart", text: "Sepetim", isHighlighted: currentView == .basket)
            }
            
            Spacer()
            
            NavigationLink(destination: AccountView()) {
                ButtonBarItem(systemName: currentView == .account ? "person.fill": "person", text: "Hesabım", isHighlighted: currentView == .account)
            }
            
            Spacer()
            
        }
    }
}

#Preview {
    ButtonBarView(currentView: .home)
}
