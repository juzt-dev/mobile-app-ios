//
//  ProfileView.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppConstants.UI.spacing * 2) {
                    if let user = viewModel.user {
                        profileHeader(user: user)
                        profileDetails(user: user)
                    }
                    
                    logoutButton
                }
                .padding(AppConstants.UI.padding)
            }
            .navigationTitle("Profile")
            .loading(viewModel.isLoading)
            .task {
                await viewModel.fetchProfile()
            }
        }
    }
    
    private func profileHeader(user: User) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(AppColors.primary)
            
            Text(user.name)
                .font(AppTypography.title2)
                .foregroundColor(AppColors.primaryText)
            
            Text(user.email)
                .font(AppTypography.callout)
                .foregroundColor(AppColors.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
    }
    
    private func profileDetails(user: User) -> some View {
        VStack(spacing: 12) {
            ProfileRow(title: "Email", value: user.email)
            ProfileRow(title: "Name", value: user.name)
            ProfileRow(title: "Member Since", value: formatDate(user.createdAt))
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(AppConstants.UI.cornerRadius)
    }
    
    private var logoutButton: some View {
        Button {
            authViewModel.logout()
        } label: {
            Text("Logout")
                .font(AppTypography.bodyBold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: AppConstants.UI.buttonHeight)
                .background(AppColors.error)
                .cornerRadius(AppConstants.UI.cornerRadius)
        }
        .padding(.top, 20)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct ProfileRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(AppTypography.callout)
                .foregroundColor(AppColors.secondaryText)
            
            Spacer()
            
            Text(value)
                .font(AppTypography.bodyBold)
                .foregroundColor(AppColors.primaryText)
        }
    }
}

#Preview {
    ProfileView()
}
