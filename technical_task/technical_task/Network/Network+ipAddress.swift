//
//  Network+ipAddress.swift
//  technical_task
//
//  Created by Marina Zhukova on 12.11.2024.
//

import Foundation
extension NetworkService {
    
    func getUserIP() async throws -> DMUserIP {
        let urlString = "https://api.ipify.org/?format=json"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        return try await request(urlRequest: urlRequest)
    }
    
    func getInfo(for ipAddress: String) async throws -> DMGetInfo {
        let urlString = "https://ipinfo.io/\(ipAddress)/geo"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        return try await request(urlRequest: urlRequest)
    }
}
