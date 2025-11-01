//
//  ProfileModels.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import Foundation

struct UpdateProfileRequest: Codable {
    let name: String
    let phone: String?
    let bio: String?
}

struct UpdateProfileResponse: Codable {
    let user: User
}
