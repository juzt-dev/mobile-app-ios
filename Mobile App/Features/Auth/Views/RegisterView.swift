//
//  RegisterView.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AuthViewModel()
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppConstants.UI.spacing) {
                    headerSection
                    
                    inputFields
                    
                    registerButton
                    
                    if let errorMessage = viewModel.errorMessage {
                        errorView(errorMessage)
                    }
                }
                .padding(AppConstants.UI.padding)
            }
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .loading(viewModel.isLoading)
        }
    }
    
    // MARK: - View Components
    
    private var headerSection: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.badge.plus")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .foregroundColor(AppColors.primary)
            
            Text("Create Account")
                .font(AppTypography.title2)
                .foregroundColor(AppColors.primaryText)
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
    
    private var inputFields: some View {
        VStack(spacing: AppConstants.UI.spacing) {
            TextField("Full Name", text: $name)
                .textContentType(.name)
                .textFieldStyle(RoundedTextFieldStyle())
            
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(RoundedTextFieldStyle())
            
            SecureField("Password", text: $password)
                .textContentType(.newPassword)
                .textFieldStyle(RoundedTextFieldStyle())
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textContentType(.newPassword)
                .textFieldStyle(RoundedTextFieldStyle())
        }
    }
    
    private var registerButton: some View {
        Button {
            Task {
                await viewModel.register(email: email, password: password, name: name)
                if viewModel.isAuthenticated {
                    dismiss()
                }
            }
        } label: {
            Text("Register")
                .font(AppTypography.bodyBold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: AppConstants.UI.buttonHeight)
                .background(AppColors.primary)
                .cornerRadius(AppConstants.UI.cornerRadius)
        }
        .disabled(!isFormValid)
        .opacity(isFormValid ? 1.0 : 0.6)
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
    
    private var isFormValid: Bool {
        !name.isEmpty && !email.isEmpty && !password.isEmpty && password == confirmPassword
    }
}

#Preview {
    RegisterView()
}
