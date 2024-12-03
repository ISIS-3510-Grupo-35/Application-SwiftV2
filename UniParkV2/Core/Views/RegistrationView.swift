//
//  SignupView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 28/10/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @StateObject var viewModel = RegistrationViewModel(service: MockAuthService())
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
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
                
                TextField("Enter your fullname", text: $fullname)
                    .modifier(PrimaryTextFieldModifier())
                
            }
            
            Button {
                Task { await  viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                }
            } label: {
                Text("Create account")
                    .modifier(PrimaryButtonModifier())
            }
            .padding(.vertical)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            
            Spacer()
            
            Divider()
            
            Button{
                dismiss()
            } label: {
                HStack(spacing: 2) {
                    Text("Already have an account?")
                    Text("Login")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
            }
            .padding(.vertical)
        }
    }
}

//MARK - Authentication protocol

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty &&
        email.contains("@") &&
        !password.isEmpty &&
        password.count > 5 &&
        !fullname.isEmpty
    }
}

#Preview {
    RegistrationView()
}
