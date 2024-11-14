//
//  Font+Custom.swift
//  technical_task
//
//  Created by Marina Zhukova on 11.11.2024.
//

import SwiftUI

extension Font {

    static func customFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        Font.custom("Montserrat", size: size).weight(weight)
    }
    
    // Headline Fonts
    static let headline1 = customFont(size: 28, weight: .bold)
    static let headline2 = customFont(size: 21, weight: .bold)
    static let headline3 = customFont(size: 16, weight: .bold)
    
    // Subtitle
    static let subtitle = customFont(size: 14, weight: .bold)
    
    // Body Fonts
    static let body1 = customFont(size: 16, weight: .medium)
    static let body2 = customFont(size: 14, weight: .medium)
    static let body3 = customFont(size: 14, weight: .regular)
    
    // Captions
    static let caption = customFont(size: 12, weight: .medium)
    static let caption2 = customFont(size: 12, weight: .regular)
}
