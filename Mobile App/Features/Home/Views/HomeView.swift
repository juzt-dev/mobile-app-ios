//
//  HomeView.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(errorMessage)
                } else {
                    contentView
                }
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            await viewModel.fetchItems()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .task {
                await viewModel.fetchItems()
            }
        }
    }
    
    private var contentView: some View {
        ScrollView {
            LazyVStack(spacing: AppConstants.UI.spacing) {
                ForEach(viewModel.items) { item in
                    HomeItemCard(item: item)
                }
            }
            .padding(AppConstants.UI.padding)
        }
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(AppColors.error)
            
            Text(message)
                .font(AppTypography.body)
                .foregroundColor(AppColors.secondaryText)
                .multilineTextAlignment(.center)
            
            Button("Retry") {
                Task {
                    await viewModel.fetchItems()
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

struct HomeItemCard: View {
    let item: HomeItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.title)
                .font(AppTypography.title3)
                .foregroundColor(AppColors.primaryText)
            
            Text(item.description)
                .font(AppTypography.body)
                .foregroundColor(AppColors.secondaryText)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(AppConstants.UI.cornerRadius)
    }
}

#Preview {
    HomeView()
}
