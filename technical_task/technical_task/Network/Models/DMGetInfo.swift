//
//  DMGetInfo.swift
//  technical_task
//
//  Created by Marina Zhukova on 12.11.2024.
//

import Foundation

struct DMGetInfo:  Decodable {
 
    let ip: String
    let hostname: String
    let city: String
    let region: String
    let country: String
    let loc: String
    let org: String
    let postal: String
    let timezone: String
    let readme: String

}

