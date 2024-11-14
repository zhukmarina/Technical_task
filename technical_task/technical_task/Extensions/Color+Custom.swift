//
//  Color+Custom.swift
//  technical_task
//
//  Created by Marina Zhukova on 11.11.2024.
//

import SwiftUI

extension Color {
    // Basics
    static let basicDark = Color(hex: "#2C363F")
    static let basicWhite = Color(hex: "#FFFFFF")
    static let basicGreyDark = Color(hex: "#7B8085")
    static let basicGreyMedium = Color(hex: "#C1C5C7")
    static let basicGreyBlue = Color(hex: "#E0E3E7")
    static let basicGreyLight = Color(hex: "#F4F5F5")
    
    // Blue
    static let blueMain = Color(hex: "#0061AF")
    static let blueMedium = Color(hex: "#EBF1FB")
    static let blueGrey = Color(hex: "#E6EDF8")
    static let blueLight = Color(hex: "#F4F7FC")
    
    // Red
    static let redMain = Color(hex: "#E60033")
    static let redMedium = Color(hex: "#FE6975")
    static let redLight = Color(hex: "#FEF0F1")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.hasPrefix("#") ? hex.index(after: hex.startIndex) : hex.startIndex
        
        var rgbValue: UInt64 = 0
        if scanner.scanHexInt64(&rgbValue) {
            let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
            let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
            let b = Double(rgbValue & 0x0000FF) / 255.0
            self.init(red: r, green: g, blue: b)
        } else {
            self.init(.clear) 
            print("Error: Invalid hex code \(hex)")
        }
    }
}
