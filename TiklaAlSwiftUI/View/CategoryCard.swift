//
//  CategoryCard.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 14.02.2024.
//

import SwiftUI

struct CategoryCard: View {
    
    var imageName: String
    var text: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 90, height: 90)
            
            Text(text)
                .font(.subheadline)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    CategoryCard(imageName: "thirt", text: "Tshirt")
}
