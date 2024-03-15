//
//  CategoryView.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 15.02.2024.
//

import SwiftUI

struct CategoryView: View {
    
    @State var categoryName: String
    @State var category: String
    
    @ObservedObject var productsViewModel = ProductViewModel()
    
    @State private var products: [Products] = []
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            HStack {
                TextField("Kategori Ara", text: $category)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .frame(height: 40)
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(5)
                    .padding(.trailing)
                
                Button(action: {
                    Task {
                        await searchCategory()
                    }
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.red)
                        .frame(width: 10)
                        .padding(.trailing)
                })
            }
            .padding(.top)
            .padding(.leading)
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                    ForEach(productsViewModel.products, id: \.id) { products in
                        NavigationLink(destination: DetailsView(products: products, category: "")) {
                            ProductCard(product: products)
                        }
                    }
                }
            }
            .padding(.top, 5)
            .task {
                await productsViewModel.downloadProductsContinuation(url: URL(string: "https://dummyjson.com/products/category/\(categoryName)")!)
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
    
    func searchCategory() async {
        guard let url = URL(string: "https://dummyjson.com/products/category/\(category)") else {
            return
        }
        await productsViewModel.downloadProductsContinuation(url: url)
    }
}

#Preview {
    CategoryView(categoryName: "", category: "")
}
