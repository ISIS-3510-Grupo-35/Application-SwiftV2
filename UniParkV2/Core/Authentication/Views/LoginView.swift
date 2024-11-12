//
//  LoginView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 28/10/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject var viewModel: LoginViewModel
    
    @Environment(\.dismiss) var dismiss
    
    private let authManager: AuthManager
    
    init (authManager: AuthManager) {
        self.authManager = authManager
        self._viewModel = StateObject(wrappedValue: LoginViewModel(authManager: authManager))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(.uniparkLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                VStack {
                    TextField("Enter your email", text: $email)
                        .modifier(PrimaryTextFieldModifier())
                    
                    SecureField("Enter your password", text: $password)
                        .modifier(PrimaryTextFieldModifier())
                }
                
                NavigationLink {
                    
                } label: {
                    Text("Forgot password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Button {
                    print("DEBUG: Log in")
                    Task {
                        await viewModel.login(withEmail: email, password: password)
                        dismiss()
                    }
                } label: {
                    Text("Login")
                        .modifier(PrimaryButtonModifier())
                }
                .padding(.vertical)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 2) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                }
                .padding(.vertical)
            }
        }
    }
}

// MARK - Authentication protocol

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty &&
        email.contains("@") &&
        !password.isEmpty
    }
}

#Preview {
    LoginView(authManager: AuthManager(service: MockAuthService()))
}
