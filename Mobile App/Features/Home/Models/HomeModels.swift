//
//  HomeModels.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import Foundation

struct HomeItem: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let imageURL: String?
    let createdAt: Date
}

struct HomeResponse: Codable {
    let items: [HomeItem]
    let total: Int
}
