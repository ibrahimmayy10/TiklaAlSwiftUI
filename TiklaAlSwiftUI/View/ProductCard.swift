//
//  ProductCard.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 14.02.2024.
//

import SwiftUI

struct ProductCard: View {
    
    var product: Products?
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: (product?.thumbnail)!)) { image in image
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 160)
                    .cornerRadius(10)
            }
            
            Text(product?.title ?? "")
                .font(.subheadline)
                .foregroundColor(.primary)
                .padding(.top, 5)
            
            HStack {
                Text("$\(String(product?.price ?? 0))")
                    .font(.subheadline)
                    .foregroundStyle(.red)
                
                Image(systemName: "heart.fill")
                    .aspectRatio(contentMode: .fill)
                    .font(.system(size: 15))
                    .foregroundStyle(.red)
                    .padding(.leading, 50)
                
                let count = Int((product?.discountPercentage ?? 0) * 100)
                
                Text(String(count))
                    .font(.caption)
                    .foregroundStyle(.black)
            }
            
            VStack {
                Image(systemName: "cube.box")
                    .foregroundStyle(Color(uiColor: .darkGray))
                
                Text("Kargo Bedava")
                    .font(.system(size: 10))
                    .lineLimit(2)
                    .frame(width: 50)
                    .foregroundStyle(.black)
            }
            .padding(.top, 5)
        }
        .frame(width: 170, height: 300)
        .padding(5)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    ProductCard()
}
