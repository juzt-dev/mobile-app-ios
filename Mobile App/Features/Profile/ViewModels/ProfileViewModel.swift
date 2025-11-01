//
//  ProfileViewModel.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import Foundation
import Combine

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchProfile() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // let response: User = try await APIClient.shared.request(.profile)
            // user = response
            
            // Mock data
            user = User(
                id: UUID(),
                email: "user@example.com",
                name: "John Doe",
                createdAt: Date(),
                updatedAt: Date()
            )
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func updateProfile(name: String, phone: String?, bio: String?) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let request = UpdateProfileRequest(name: name, phone: phone, bio: bio)
            let response: UpdateProfileResponse = try await APIClient.shared.request(
                .updateProfile,
                method: .put,
                body: request
            )
            user = response.user
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
