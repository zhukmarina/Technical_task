//
//  NetworkService.swift
//  technical_task
//
//  Created by Marina Zhukova on 12.11.2024.
//

import Foundation

class NetworkService {

    var configuration: URLSessionConfiguration?

    func request<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error: \(httpResponse.statusCode)"])
        }

        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Failed to decode JSON: \(error.localizedDescription)")
            throw error
        }
    }
}
