//
//  UserInfoModels.swift
//  technical_task
//
//  Created by Marina Zhukova on 12.11.2024.
//

import Foundation
import SwiftUI

class UserInfoModels: ObservableObject {
    
    @Published var userIP: String = ""
    @Published var ipInfo: DMGetInfo?
    @Published var arrayForIpInfo: [(title: String, value: String)] = []
    @Published var errorMessage: String?

    
    private let networkService = NetworkService()
    
    func fetchUserIP() async -> String? {
        do {
            let result = try await networkService.getUserIP()
            DispatchQueue.main.async {
                self.userIP = result.ip
            }
            await fetchIPInfo(for: result.ip) 
            return result.ip
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Error: \(error.localizedDescription)"
            }
            return nil
        }
    }
    
    func fetchIPInfo(for ipAddress: String) async {
        do {
            let result = try await networkService.getInfo(for: ipAddress)
            DispatchQueue.main.async {
                self.ipInfo = result
                self.arrayForIpInfo = self.mapIPInfoToArray(result)
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.ipInfo = nil
                self.arrayForIpInfo = []
            }
        }
    }
    
    func mapIPInfoToArray(_ info: DMGetInfo) -> [(title: String, value: String)] {
        let properties: [(title: String, value: String)] = [
            ("IP", info.ip),
            ("Hostname", info.hostname),
            ("City", info.city),
            ("Region", info.region),
            ("Country", info.country),
            ("Location", info.loc),
            ("Organization", info.org),
            ("Postal", info.postal),
            ("Timezone", info.timezone),
            ("Readme", info.readme)
        ]
        
        var result: [(title: String, value: String)] = []
            for (key, value) in properties {
                result.append((title: key, value: value))
            }
        
        return result
    }

}
