//
//  AppConstants.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import Foundation

enum AppConstants {
    enum API {
        static let baseURL = "http://localhost:8080"
        static let timeout: TimeInterval = 30
        static let maxRetries = 3
    }
    
    enum UI {
        static let cornerRadius: CGFloat = 12
        static let spacing: CGFloat = 16
        static let padding: CGFloat = 20
        static let buttonHeight: CGFloat = 50
        static let animationDuration: Double = 0.3
    }
    
    enum Validation {
        static let minPasswordLength = 8
        static let maxPasswordLength = 128
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    
    enum App {
        static let name = "Mobile App"
        static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        static let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
}
