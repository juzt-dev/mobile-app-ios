//
//  PrimaryButton.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isLoading: Bool = false
    var isDisabled: Bool = false
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text(title)
                        .font(AppTypography.bodyBold)
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: AppConstants.UI.buttonHeight)
            .background(isDisabled ? AppColors.gray : AppColors.primary)
            .cornerRadius(AppConstants.UI.cornerRadius)
        }
        .disabled(isDisabled || isLoading)
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(title: "Normal Button", action: {})
        PrimaryButton(title: "Loading Button", action: {}, isLoading: true)
        PrimaryButton(title: "Disabled Button", action: {}, isDisabled: true)
    }
    .padding()
}
