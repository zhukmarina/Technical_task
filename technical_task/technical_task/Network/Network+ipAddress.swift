//
//  Network+ipAddress.swift
//  technical_task
//
//  Created by Marina Zhukova on 12.11.2024.
//

import Foundation

extension NetworkService {
    
    func getUserIP() async throws -> DMUserIP {
           return try await fetch(from: "https://api.ipify.org/?format=json", as: DMUserIP.self)
       }
    
    func getInfo(for ipAddress: String) async throws -> DMGetInfo {
            return try await fetch(from: "https://ipinfo.io/\(ipAddress)/geo", as: DMGetInfo.self)
        }
}
