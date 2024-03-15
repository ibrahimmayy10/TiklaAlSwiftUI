//
//  MainView.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 14.02.2024.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var productsViewModel: ProductViewModel
    @State var category: String
    
    var categories = [
        Category(text: "T-shirt", imageName: "tshirt", category: "mens-shirts"),
        Category(text: "Ayakkabı", imageName: "ayakkabi", category: "mens-shoes"),
        Category(text: "Telefon", imageName: "electronics", category: "smartphones"),
        Category(text: "Elbise", imageName: "elbise", category: "womens-dresses"),
        Category(text: "Takı & Mücevher", imageName: "jewellery", category: "womens-jewellery"),
        Category(text: "Güneş Gözlüğü", imageName: "gozluk", category: "sunglasses")
    ]

    var design = [
        Design(image: "apple"),
        Design(image: "pullbear"),
        Design(image: "xiaomi"),
        Design(image: "nike"),
        Design(image: "adidas")
    ]
    
    @ObservedObject var mainViewModel: MainViewModel
    @State var isSearchActive: Bool = false
    
    init() {
        self.productsViewModel = ProductViewModel()
        self.category = String()
        self.mainViewModel = MainViewModel()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.red)
                        .frame(width: 10)
                        .padding(.leading)
                    
                    TextField("Kategori Ara", text: $category)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .frame(height: 40)
                        .background(Color(uiColor: .systemGray6))
                        .cornerRadius(5)
                        .padding()
                        .onTapGesture {
                            isSearchActive = true
                        }
                }
                
                Text("Kategoriler")
                    .padding(.leading, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                        ForEach(categories) { category in
                            NavigationLink(destination: CategoryView(categoryName: category.category, category: "")) {
                                CategoryCard(imageName: category.imageName, text: category.text)
                            }
                        }
                    }
                }
                .frame(height: 110)
                
                HStack {
                    Text("Sana özel öneriler")
                        .font(.title2)
                        .bold()
                        .padding(.leading, 15)
                    
                    NavigationLink(destination: AllProductsView()) {
                        Text("Tüm Ürünler")
                            .foregroundStyle(Color(uiColor: .red))
                            .padding(.leading, 40)
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                        ForEach(productsViewModel.products, id: \.id) { product in
                            NavigationLink(destination: DetailsView(products: product, category: "")) {
                                ProductCard(product: product)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 300)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(design) { design in
                            DesignCard(image: design.image)
                        }
                    }
                }

                ButtonBarView(currentView: .home)
            }
            .frame(height: .infinity)
            .task {
                await productsViewModel.downloadProductsContinuation(url: URL(string: "https://dummyjson.com/products/category/laptops")!)
            }
            .background(
                NavigationLink(destination: CategoryView(categoryName: category, category: ""), isActive: $isSearchActive) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainView()
}
