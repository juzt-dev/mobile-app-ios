//
//  APIEndpoint.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import Foundation

enum APIEndpoint {
    // Authentication
    case login
    case register
    case logout
    case refreshToken
    
    // User
    case profile
    case updateProfile
    case deleteAccount
    
    // Add more endpoints as needed
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .register:
            return "/auth/register"
        case .logout:
            return "/auth/logout"
        case .refreshToken:
            return "/auth/refresh"
        case .profile:
            return "/user/profile"
        case .updateProfile:
            return "/user/profile"
        case .deleteAccount:
            return "/user/account"
        }
    }
}
