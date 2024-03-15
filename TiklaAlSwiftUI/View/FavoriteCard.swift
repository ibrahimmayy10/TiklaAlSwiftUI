//
//  FavoriteCard.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 29.02.2024.
//

import SwiftUI

struct FavoriteCard: View {
    
    var products: BasketProductModel
    @ObservedObject var detailsViewModel = DetailsViewModel()
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: products.thumbnail)) { image in image
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 160)
                    .cornerRadius(10)
            }
            
            VStack {
                HStack {
                    Text(products.title)
                    
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        .padding(.leading, 40)
                }
                .padding(.bottom, 10)
                
                HStack {
                    Text(String(products.rating))
                        .font(.system(size: 13))
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 11))
                        .foregroundStyle(.red)
                        .frame(width: 10)
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 11))
                        .foregroundStyle(.red)
                        .frame(width: 10)
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 11))
                        .foregroundStyle(.red)
                        .frame(width: 10)
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 11))
                        .foregroundStyle(.red)
                        .frame(width: 10)
                    
                    Image(systemName: "star")
                        .font(.system(size: 11))
                        .foregroundStyle(.red)
                        .frame(width: 10)
                    
                    let count = Int(products.discountPercentage * 100)
                    
                    Text("(\(String(count)))")
                        .font(.system(size: 13))
                }
                
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 2)
                            .foregroundStyle(Color(uiColor: .systemGray6))
                            .frame(width: 45, height: 45)
                        
                        VStack {
                            Image(systemName: "truck.box.badge.clock.fill.rtl")
                                .frame(width: 20, height: 20)
                                .font(.system(size: 15))
                                .foregroundStyle(.green)
                            
                            Text("Hızlı Teslimat")
                                .font(.system(size: 8))
                                .lineLimit(2)
                                .frame(width: 40, alignment: .center)
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 2)
                            .foregroundStyle(Color(uiColor: .systemGray6))
                            .frame(width: 45, height: 45)
                        
                        VStack {
                            Image(systemName: "cube.box")
                                .frame(width: 20, height: 20)
                                .font(.system(size: 15))
                                .foregroundStyle(Color(uiColor: .darkGray))
                            
                            Text("Kargo Bedava")
                                .font(.system(size: 8))
                                .lineLimit(2)
                                .frame(width: 40, alignment: .center)
                        }
                    }
                    Spacer()
                }
                
//                        Button(action: {
//                            detailsViewModel.addBasket(product: products)
//                        }, label: {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 20)
//                                    .foregroundStyle(.red)
//                                Text("Sepete Ekle")
//                                    .foregroundStyle(.white)
//                                    .font(.subheadline)
//                            }
//                        })
//                        .frame(width: 125, height: 35)
//                        .padding(.top, 20)
//                        .padding(.leading, 80)
            }
        }
    }
}

#Preview {
    FavoriteCard(products: BasketProductModel(id: 1, title: "", thumbnail: "", price: 1, description: "", discountPercentage: 1, rating: 1, images: []))
}
