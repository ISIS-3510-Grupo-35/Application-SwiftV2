//
//  UserProfileHeaderView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 30/10/24.
//

import SwiftUI

struct UserProfileHeaderView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(.white)
                .frame(width: 300, height: 200)
                .shadow(radius: 10)
            
            VStack (spacing: 12) {
                CircularProfileImageView(size: .xLarge)
                
                VStack {
                    Text("John Doe")
                        .font(.headline)
                    
                    Text("Driver")
                        .font(.footnote)
                }
            }
        }
    }
}

#Preview {
    UserProfileHeaderView()
}
