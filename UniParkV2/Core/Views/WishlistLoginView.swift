//
//  WishlistLoginView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 31/10/24.
//

import SwiftUI

struct WishlistLoginView: View {
    @Binding var showLogin: Bool
    var body: some View {
        VStack (alignment: .leading, spacing: 32) {
            VStack (alignment: .leading, spacing: 4) {
                Text("Log in to view your wishlists")
                    .font(.headline)
                
                Text("You can create, view or edit your wishlists once you've logged in")
                    .font(.footnote)
            }
            
            Button {
                showLogin.toggle()
            } label: {
                Text("Log in")
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 40)
                    .background(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            Spacer()
        }
    }
}

#Preview {
    WishlistLoginView(showLogin: .constant(false))
}
