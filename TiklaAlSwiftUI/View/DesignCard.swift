//
//  DesignCard.swift
//  TiklaAlSwiftUI
//
//  Created by İbrahim Ay on 15.02.2024.
//

import SwiftUI

struct DesignCard: View {
    
    var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: .infinity)
            .padding(.leading, 10)
    }
}

#Preview {
    DesignCard(image: "")
}
