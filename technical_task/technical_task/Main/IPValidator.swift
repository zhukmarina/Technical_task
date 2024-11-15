//
//  IPValidator.swift
//  technical_task
//
//  Created by Marina Zhukova on 13.11.2024.
//

import Foundation

func validateIP(_ input: inout String, isValid: inout Bool?) {
    
    let filtered = input.filter { "0123456789.".contains($0) }
    if filtered.count > 15 {
        input = String(filtered.prefix(15))
    } else {
        input = filtered
    }
   
    let regex = try! NSRegularExpression(pattern: "\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b")
    let range = NSRange(location: 0, length: input.utf16.count)
    isValid = regex.firstMatch(in: input, options: [], range: range) != nil
    
}

