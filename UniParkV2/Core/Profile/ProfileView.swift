//
//  ProfileView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 24/10/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var authManager: AuthManager
    @State private var showLogin = false
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    var body: some View {
        VStack {
            // profile login view
            if authManager.userSessionId == nil {
                ProfileLoginView(showLogin: $showLogin)
            } else {
                UserProfileHeaderView()
            }
            
            // profile options
            //NavigationStack {
                VStack (spacing: 24) {
                    ProfileOptionRowView(imageName: "gear", title: "Settings")
                    ProfileOptionRowView(imageName: "gear", title: "Accesibility")
                    ProfileOptionRowView(imageName: "questionmark.circle", title: "Visit the help center")
                }
            //}
            .padding(.vertical)
            
            if authManager.userSessionId != nil {
                Button {
                    authManager.signOut()
                } label: {
                    Text("Log out")
                        .underline()
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .sheet(isPresented: $showLogin, content: {
            LoginView(authManager: authManager)
        })
        .padding()
    }
}

#Preview {
    ProfileView(authManager: AuthManager(service: MockAuthService()))
}
