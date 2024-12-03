//
//  WishlistEmptyStateView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 31/10/24.
//

import SwiftUI

struct WishlistEmptyStateView: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            Text("Create your first wishlist")
                .font(.headline)
            Text("As you explore, tap the heart icon to save your favorite parking lots to a wishlist")
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    WishlistEmptyStateView()
}
