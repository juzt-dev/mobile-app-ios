//
//  AppTypography.swift
//  Mobile App
//
//  Created by Ho Van Chuong on 1/11/25.
//

import SwiftUI

enum AppTypography {
    // Headings
    static let largeTitle = Font.largeTitle.weight(.bold)
    static let title = Font.title.weight(.semibold)
    static let title2 = Font.title2.weight(.semibold)
    static let title3 = Font.title3.weight(.medium)
    
    // Body
    static let body = Font.body
    static let bodyBold = Font.body.weight(.semibold)
    static let callout = Font.callout
    
    // Small text
    static let caption = Font.caption
    static let caption2 = Font.caption2
    static let footnote = Font.footnote
}
