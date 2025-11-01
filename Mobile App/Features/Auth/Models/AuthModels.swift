//
//  AuthModels.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import Foundation

// MARK: - Login
struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String
    let refreshToken: String
    let user: User
}

// MARK: - Register
struct RegisterRequest: Codable {
    let email: String
    let password: String
    let name: String
}

struct RegisterResponse: Codable {
    let token: String
    let refreshToken: String
    let user: User
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: UUID
    let email: String
    let name: String
    let createdAt: Date
    let updatedAt: Date
}
