//
//  MainScreenView.swift
//  technical_task
//
//  Created by Marina Zhukova on 11.11.2024.
//
import SwiftUI

struct MainScreenView: View {
    
    @StateObject private var viewModel = UserInfoModels()
    @State private var ipAddress: String = ""
    @State private var isValid: Bool? = nil
    @State private var showingAlert = false
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 16) {
            TextFieldforIP(ipAddress: $ipAddress, isValid: $isValid, clearIPAction: clearIP)
            VStack(spacing: 8) {
                Button(action: {
                    validateIP(&ipAddress, isValid: &isValid)
                    if isValid == true {
                        Task {
                            isLoading = true
                            await viewModel.fetchIPInfo(for: ipAddress)
                            isLoading = false
                        }
                    } else {
                        showingAlert = true
                    }
                }) {
                    Text("Get Info")
                        .font(.headline3)
                        .lineSpacing(20)
                        .foregroundColor(.basicWhite)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blueMain)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Alert error"),
                        message: Text("Wrong IP! Please provide a valid IP address"),
                        primaryButton: .default(Text("OK"), action: {
                            clearIP()
                        }),
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }
                
                Button(action: {
                    Task {
                        isLoading = true
                        let fetchedIP = await viewModel.fetchUserIP()
                        ipAddress = fetchedIP ?? ""
                        isValid = true
                        isLoading = false
                    }
                }) {
                    Text("Find Me")
                        .font(.headline3)
                        .foregroundColor(.blueMain)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blueMedium)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    clearIP()
                }) {
                    Text("Reset")
                        .font(.headline3)
                        .foregroundColor(.redMedium)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.redLight)
                        .cornerRadius(10)
                }
            }
           
            if isLoading {
                ProgressView()
                    .padding()
            } else if !viewModel.arrayForIpInfo.isEmpty {
                IPInfoView(arrayForIpInfo: viewModel.arrayForIpInfo)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
    
    private func clearIP() {
            ipAddress = ""
            isValid = nil
            viewModel.ipInfo = nil
            viewModel.errorMessage = nil
        }
}
