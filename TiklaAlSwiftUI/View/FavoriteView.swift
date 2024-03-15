//
//  FavoriteView.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 29.02.2024.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var favoriteViewModel = FavoriteViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 2)
                    .foregroundStyle(Color(uiColor: .systemGray6))
                    .frame(height: 40)
                Text("Favorilerim")
                    .bold()
                    .font(.title3)
            }
            
            List {
                ForEach(favoriteViewModel.products, id: \.id) { products in
                    NavigationLink(destination: DetailsView(products: products, category: "", basketProducts: products)) {
                        FavoriteCard(products: products)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        let productToRemove = favoriteViewModel.products[index]
                        favoriteViewModel.removeFavorite(product: productToRemove)
                    }
                })
            }
            
            ButtonBarView(currentView: .favorites)
        }
        .task {
            favoriteViewModel.getDataFavorite()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    FavoriteView()
}
