//
//  UserInfoModels.swift
//  technical_task
//
//  Created by Marina Zhukova on 12.11.2024.
//
import Foundation

class UserInfoModels: ObservableObject {
    
    @Published var ipAddress: String = ""
    @Published var isValid: Bool? = nil
    @Published var ipInfo: DMGetInfo?
    @Published var arrayForIpInfo: [(title: String, value: String)] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var showingAlert = false
    
    private let networkService = NetworkService()
    
    @MainActor
    func fetchUserIP() async -> String? {
        do {
            let result = try await networkService.getUserIP()
            self.ipAddress = result.ip
            await fetchIPInfo(for: result.ip)
            return result.ip
        } catch {
            self.errorMessage = "Error: \(error.localizedDescription)"
            return nil
        }
    }
    
    @MainActor
    func fetchIPInfo(for ipAddress: String) async {
        do {
            let result = try await networkService.getInfo(for: ipAddress)
                self.ipInfo = result
                self.arrayForIpInfo = self.mapIPInfoToArray(result)
        } catch {
                self.errorMessage = error.localizedDescription
                self.ipInfo = nil
                self.arrayForIpInfo = []
        }
    }
    
    func mapIPInfoToArray(_ info: DMGetInfo) -> [(title: String, value: String)] {
        return [
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
    }
    
    func clearIP() {
        ipAddress = ""
        isValid = nil
        ipInfo = nil
        errorMessage = nil
        arrayForIpInfo = []
    }
    
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
}
