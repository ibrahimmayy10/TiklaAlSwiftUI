//
//  BasketView.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 21.02.2024.
//

import SwiftUI

struct BasketView: View {
    
    @ObservedObject var basketViewModel = BasketViewModel()
    
    @State private var totalPrice: Double = 0.0
    
    @State var isPresented = false
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 2)
                    .foregroundStyle(Color(uiColor: .systemGray6))
                    .frame(height: 40)
                Text("Sepetim")
                    .bold()
                    .font(.title3)
            }
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                    ForEach(basketViewModel.products, id: \.id) { product in
                        HStack {
                            AsyncImage(url: URL(string: product.thumbnail)) { image in image
                                    .image?
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 160)
                                    .cornerRadius(10)
                            }
                            
                            VStack {
                                Text(product.title)
                                
                                HStack {
                                    Text("Tahmini Kargoya Teslim:")
                                        .font(.system(size: 12))
                                        .foregroundStyle(Color(uiColor: .darkGray))
                                    
                                    Text("2 gün içinde")
                                        .padding(.leading, 3)
                                        .font(.system(size: 10))
                                        .foregroundStyle(Color(uiColor: .systemGray))
                                }
                                .padding(.top, 5)
                                
                                HStack {
                                    Button(action: {
                                        if let piece = product.piece, piece > 1 {
                                            basketViewModel.decreasePiece(for: product)
                                        }
                                    }) {
                                        Image(systemName: "minus")
                                            .foregroundStyle(.white)
                                            .cornerRadius(50)
                                    }
                                    .frame(width: 17, height: 17)
                                    .background(.red)
                                    .cornerRadius(50)

                                    Text(String(product.piece ?? 1))

                                    Button(action: {
                                        basketViewModel.increasePiece(for: product)
                                    }) {
                                        Image(systemName: "plus")
                                            .foregroundStyle(.white)
                                            .cornerRadius(50)
                                    }
                                    .frame(width: 17, height: 17)
                                    .background(.red)
                                    .cornerRadius(50)
                                    
                                    Text("$\(String(product.price))")
                                        .foregroundStyle(.red)
                                        .padding(.leading, 30)
                                }
                                .padding(.top, 5)
                                
                                Text("Kargo Bedava")
                                    .foregroundStyle(.green)
                                    .padding(.top, 5)
                            }
                        }
                    }
                }
            }
            
            HStack {
                VStack {
                    Text("Toplam")
                        .foregroundStyle(Color(uiColor: .darkGray))
                    
                    Text("$\(String(format: "%.2f", basketViewModel.calculateTotalPrice()))")
                        .font(.title2)
                }
                
                Button(action: {
                    var totalPrice = basketViewModel.calculateTotalPrice()
                    
                    basketViewModel.confirmBasket(totalPrice: totalPrice) { success in
                        if success {
                           isPresented = true
                        } else {
                            
                        }
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.red)
                        Text("Sepeti Onayla")
                            .foregroundStyle(.white)
                    }
                })
                .frame(width: 230, height: 40)
                .padding(.leading, 30)
            }
            
            ButtonBarView(currentView: .basket)
        }
        .onAppear {
            totalPrice = basketViewModel.calculateTotalPrice()
        }
        .task {
            basketViewModel.getDataBasket()
        }
        .navigationBarBackButtonHidden()
        .background(
            NavigationLink(destination: AccountView(), isActive: $isPresented) { EmptyView() }
        )
    }
}

#Preview {
    BasketView()
}
