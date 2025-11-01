//
//  HomeViewModel.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var items: [HomeItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchItems() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Example API call (uncomment when backend is ready)
            // let response: HomeResponse = try await APIClient.shared.request(.home)
            // items = response.items
            
            // Mock data for now
            items = mockItems()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func mockItems() -> [HomeItem] {
        [
            HomeItem(
                id: UUID(),
                title: "Welcome",
                description: "Welcome to Mobile App",
                imageURL: nil,
                createdAt: Date()
            ),
            HomeItem(
                id: UUID(),
                title: "Getting Started",
                description: "Learn how to use the app",
                imageURL: nil,
                createdAt: Date()
            )
        ]
    }
}
