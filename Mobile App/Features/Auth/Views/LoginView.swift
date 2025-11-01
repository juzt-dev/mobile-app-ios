//
//  LoginView.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var showingRegister = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppConstants.UI.spacing) {
                    headerSection
                    
                    inputFields
                    
                    loginButton
                    
                    registerLink
                    
                    if let errorMessage = viewModel.errorMessage {
                        errorView(errorMessage)
                    }
                }
                .padding(AppConstants.UI.padding)
            }
            .navigationTitle("Login")
            .loading(viewModel.isLoading)
            .sheet(isPresented: $showingRegister) {
                RegisterView()
            }
        }
    }
    
    // MARK: - View Components
    
    private var headerSection: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(AppColors.primary)
            
            Text("Welcome Back")
                .font(AppTypography.title)
                .foregroundColor(AppColors.primaryText)
        }
        .padding(.top, 40)
        .padding(.bottom, 20)
    }
    
    private var inputFields: some View {
        VStack(spacing: AppConstants.UI.spacing) {
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(RoundedTextFieldStyle())
            
            SecureField("Password", text: $password)
                .textContentType(.password)
                .textFieldStyle(RoundedTextFieldStyle())
        }
    }
    
    private var loginButton: some View {
        Button {
            Task {
                await viewModel.login(email: email, password: password)
            }
        } label: {
            Text("Login")
                .font(AppTypography.bodyBold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: AppConstants.UI.buttonHeight)
                .background(AppColors.primary)
                .cornerRadius(AppConstants.UI.cornerRadius)
        }
        .disabled(email.isEmpty || password.isEmpty)
        .opacity(email.isEmpty || password.isEmpty ? 0.6 : 1.0)
        .padding(.top, 8)
    }
    
    private var registerLink: some View {
        Button {
            showingRegister = true
        } label: {
            HStack(spacing: 4) {
                Text("Don't have an account?")
                    .foregroundColor(AppColors.secondaryText)
                Text("Register")
                    .foregroundColor(AppColors.primary)
                    .fontWeight(.semibold)
            }
            .font(AppTypography.callout)
        }
        .padding(.top, 8)
    }
    
    private func errorView(_ message: String) -> some View {
        Text(message)
            .font(AppTypography.caption)
            .foregroundColor(AppColors.error)
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColors.error.opacity(0.1))
            .cornerRadius(AppConstants.UI.cornerRadius)
    }
}

// MARK: - Custom TextField Style

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(AppConstants.UI.cornerRadius)
    }
}

#Preview {
    LoginView()
}
