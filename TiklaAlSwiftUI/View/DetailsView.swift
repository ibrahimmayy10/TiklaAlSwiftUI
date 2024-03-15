//
//  DetailsView.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 19.02.2024.
//

import SwiftUI

struct DetailsView: View {
    
    @State var products: Any
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var isSearchActive: Bool = false
    @State var category: String
    
    @State var basketProducts: BasketProductModel?
    
    @ObservedObject var detailsViewModel = DetailsViewModel()
    
    @State var isPresented = false
    
    var body: some View {
        if let products = products as? Products {
            VStack {
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
                
                ScrollView {
                    HStack {
                        Button(action: {
                            if detailsViewModel.isFavorite(product: products) {
                                detailsViewModel.addFavorite(product: products)
                            } else {
                                detailsViewModel.addFavorite(product: products)
                            }
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 50)
                                    .foregroundStyle(.white)
                                    .background(
                                        Color.white
                                            .cornerRadius(50)
                                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0.0, y: 10.0))
                                Image(systemName: detailsViewModel.isFavorite(product: products) ? "heart.fill" : "heart")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.red)
                            }
                        })
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                    }
                    .frame(width: UIScreen.main.bounds.width, alignment: .trailing)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(products.images, id: \.self) { imageName in
                                if let url = URL(string: imageName) {
                                    AsyncImage(url: url) { image in image
                                            .image?
                                            .resizable()
                                            .scaledToFill()
                                    }
                                    .frame(width: UIScreen.main.bounds.width - 20, height: 500)
                                    .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .tabViewStyle(PageTabViewStyle())
                    
                    Text(products.title)
                        .font(.title2)
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                    
                    HStack {
                        Text(String(products.rating))
                        
                        Image(systemName: "star.fill")
                            .foregroundStyle(.red)
                        Image(systemName: "star.fill")
                            .foregroundStyle(.red)
                        Image(systemName: "star.fill")
                            .foregroundStyle(.red)
                        Image(systemName: "star.fill")
                            .foregroundStyle(.red)
                        Image(systemName: "star")
                            .foregroundStyle(.red)
                            .padding(.trailing, 60)
                        
                        Image(systemName: "heart")
                            .foregroundStyle(.red)
                            .padding(.leading, 50)
                        
                        let count = Int((products.discountPercentage) * 100)
                        
                        Text(String(count))
                            .foregroundStyle(.black)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top, 10)
                    
                    Text(products.description)
                        .font(.title3)
                        .padding(.top, 20)
                        .padding(.horizontal)
                    
                    VStack {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.red)
                            Image(systemName: "star.fill")
                                .foregroundStyle(.red)
                            Image(systemName: "star.fill")
                                .foregroundStyle(.red)
                            Image(systemName: "star.fill")
                                .foregroundStyle(.red)
                            Image(systemName: "star")
                                .foregroundStyle(.red)
                        }
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .padding(.leading, 30)
                        
                        Text("***** ****")
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 30)
                            .padding(.top, 10)
                        
                        Text("Çok güzel bir ürün, herkese tavsiye ederim. Ayrıca kargo hızı ve paketleme de çok iyiydi.")
                            .padding(.trailing)
                            .padding(.top, 10)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 160, alignment: .leading)
                    .padding(.top)
                    .background(Color(uiColor: .systemGray4))
                }
                
                HStack {
                    VStack {
                        Text("$\(String(products.price))")
                            .font(.title3)
                            .foregroundStyle(.red)
                        
                        Text("Kargo Bedava")
                            .foregroundStyle(.green)
                    }
                    
                    Button(action: {
                        detailsViewModel.addBasket(product: products)
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.red)
                            Text("Sepete Ekle")
                                .foregroundStyle(.white)
                        }
                    })
                    .frame(width: 230, height: 40)
                    .padding(.horizontal)
                }
                .padding(.leading, 10)
            }
            .background(
                NavigationLink(destination: CategoryView(categoryName: category, category: ""), isActive: $isSearchActive) {
                    EmptyView()
                }
                .hidden()
            )
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
        } else if let products = products as? BasketProductModel {
            VStack {
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
                
                ScrollView {
                    HStack {
                        Button(action: {
//                            if detailsViewModel.isFavorite(product: products) {
//                                detailsViewModel.addFavorite(product: products)
//                            } else {
//                                detailsViewModel.addFavorite(product: products)
//                            }
                        }, label: {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 50)
//                                    .foregroundStyle(.white)
//                                    .background(
//                                        Color.white
//                                            .cornerRadius(50)
//                                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0.0, y: 10.0))
//                                Image(systemName: detailsViewModel.isFavorite(product: products ?? Products(id: 1, title: "", description: "", price: 1, discountPercentage: 1, rating: 1, stock: 1, brand: "", category: "", thumbnail: "", images: [])) ? "heart.fill" : "heart")
//                                    .font(.system(size: 20))
//                                    .foregroundStyle(.red)
//                            }
                        })
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                    }
                    .frame(width: UIScreen.main.bounds.width, alignment: .trailing)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(products.images, id: \.self) { imageName in
                                if let url = URL(string: imageName) {
                                    AsyncImage(url: url) { image in image
                                            .image?
                                            .resizable()
                                            .scaledToFill()
                                    }
                                    .frame(width: UIScreen.main.bounds.width - 20, height: 500)
                                    .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .tabViewStyle(PageTabViewStyle())
                    
                    Text(products.title)
                        .font(.title2)
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                    
                    HStack {
                        Text(String(products.rating))
                        
                        Image(systemName: "star.fill")
                            .foregroundStyle(.red)
                        Image(systemName: "star.fill")
                            .foregroundStyle(.red)
                        Image(systemName: "star.fill")
                            .foregroundStyle(.red)
                        Image(systemName: "star.fill")
                            .foregroundStyle(.red)
                        Image(systemName: "star")
                            .foregroundStyle(.red)
                            .padding(.trailing, 60)
                        
                        Image(systemName: "heart")
                            .foregroundStyle(.red)
                            .padding(.leading, 50)
                        
                        let count = Int((products.discountPercentage) * 100)
                        
                        Text(String(count))
                            .foregroundStyle(.black)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top, 10)
                    
                    Text(products.description)
                        .font(.title3)
                        .padding(.top, 20)
                        .padding(.horizontal)
                    
                    VStack {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.red)
                            Image(systemName: "star.fill")
                                .foregroundStyle(.red)
                            Image(systemName: "star.fill")
                                .foregroundStyle(.red)
                            Image(systemName: "star.fill")
                                .foregroundStyle(.red)
                            Image(systemName: "star")
                                .foregroundStyle(.red)
                        }
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .padding(.leading, 30)
                        
                        Text("***** ****")
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 30)
                            .padding(.top, 10)
                        
                        Text("Çok güzel bir ürün, herkese tavsiye ederim. Ayrıca kargo hızı ve paketleme de çok iyiydi.")
                            .padding(.trailing)
                            .padding(.top, 10)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 160, alignment: .leading)
                    .padding(.top)
                    .background(Color(uiColor: .systemGray4))
                }
                
                HStack {
                    VStack {
                        Text("$\(String(products.price))")
                            .font(.title3)
                            .foregroundStyle(.red)
                        
                        Text("Kargo Bedava")
                            .foregroundStyle(.green)
                    }
                    
                    Button(action: {
                        detailsViewModel.addBasket(product: products)
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.red)
                            Text("Sepete Ekle")
                                .foregroundStyle(.white)
                        }
                    })
                    .frame(width: 230, height: 40)
                    .padding(.horizontal)
                }
                .padding(.leading, 10)
            }
            .background(
                NavigationLink(destination: CategoryView(categoryName: category, category: ""), isActive: $isSearchActive) {
                    EmptyView()
                }
                .hidden()
            )
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
            .background(
                NavigationLink(destination: BasketView(), isActive: $isPresented) { EmptyView() }
            )
        }
    }
}

#Preview {
    DetailsView(products: Products(id: 1, title: "Ürün Başlığı", description: "Ürün açıklaması", price: 100, discountPercentage: 10.0, rating: 4.5, stock: 50, brand: "Ürün Markası", category: "Ürün Kategorisi", thumbnail: nil, images: ["resim1.jpg", "resim2.jpg"]), category: "")
}
