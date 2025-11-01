//
//  AuthViewModel.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import Foundation
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    init() {
        checkAuthStatus()
    }
    
    func login(email: String, password: String) async {
        guard validateLoginInput(email: email, password: password) else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let request = LoginRequest(email: email, password: password)
            let response: LoginResponse = try await APIClient.shared.request(
                .login,
                method: .post,
                body: request
            )
            
            try saveAuthData(response)
            currentUser = response.user
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func register(email: String, password: String, name: String) async {
        guard validateRegisterInput(email: email, password: password, name: name) else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let request = RegisterRequest(email: email, password: password, name: name)
            let response: RegisterResponse = try await APIClient.shared.request(
                .register,
                method: .post,
                body: request
            )
            
            try saveAuthData(response)
            currentUser = response.user
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func logout() {
        KeychainManager.shared.delete(for: .authToken)
        KeychainManager.shared.delete(for: .refreshToken)
        currentUser = nil
        isAuthenticated = false
    }
    
    // MARK: - Private Methods
    
    private func checkAuthStatus() {
        if let _ = try? KeychainManager.shared.retrieve(for: .authToken) {
            isAuthenticated = true
            // Optionally fetch user profile
        }
    }
    
    private func saveAuthData(_ response: LoginResponse) throws {
        try KeychainManager.shared.save(response.token, for: .authToken)
        try KeychainManager.shared.save(response.refreshToken, for: .refreshToken)
    }
    
    private func saveAuthData(_ response: RegisterResponse) throws {
        try KeychainManager.shared.save(response.token, for: .authToken)
        try KeychainManager.shared.save(response.refreshToken, for: .refreshToken)
    }
    
    private func validateLoginInput(email: String, password: String) -> Bool {
        if !Validators.isValidEmail(email) {
            errorMessage = "Invalid email format"
            return false
        }
        
        if !Validators.isValidPassword(password) {
            errorMessage = "Password must be at least \(AppConstants.Validation.minPasswordLength) characters"
            return false
        }
        
        return true
    }
    
    private func validateRegisterInput(email: String, password: String, name: String) -> Bool {
        if !Validators.isValidName(name) {
            errorMessage = "Name must be at least 2 characters"
            return false
        }
        
        return validateLoginInput(email: email, password: password)
    }
}
