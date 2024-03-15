//
//  AllProductsView.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 19.02.2024.
//

import SwiftUI

struct AllProductsView: View {
    
    @ObservedObject var productsViewModel = ProductViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("Senin İçin Seçtik")
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                    ForEach(productsViewModel.products, id: \.id) { products in
                        NavigationLink(destination: DetailsView(products: products, category: "")) {
                            ProductCard(product: products)
                        }
                    }
                }
            }
            .padding(.top)
            .task {
                await productsViewModel.downloadProductsContinuation(url: URL(string: "https://dummyjson.com/products")!)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading:
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .frame(width: 20, height: 15)
                    .foregroundStyle(.red)
            }
        )
    }
}

#Preview {
    AllProductsView()
}
