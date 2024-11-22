//
//  MainScreenView.swift
//  technical_task
//
//  Created by Marina Zhukova on 11.11.2024.
//
import SwiftUI

struct MainScreenView: View {
    
    @StateObject private var viewModel = UserInfoModels()
    
    var body: some View {
        VStack(spacing: 16) {
            TextFieldforIP(
                ipAddress: $viewModel.ipAddress,
                isValid: $viewModel.isValid,
                clearIPAction: {
                    viewModel.clearIP()
                }
            )
            
            VStack(spacing: 8) {
                Button(action: {
                    viewModel.validateIP(&viewModel.ipAddress, isValid: &viewModel.isValid)
                    if viewModel.isValid == true {
                        Task {
                            viewModel.isLoading = true
                            await viewModel.fetchIPInfo(for: viewModel.ipAddress)
                            viewModel.isLoading = false
                        }
                    } else {
                        viewModel.showingAlert = true
                    }
                }) {
                    Text("Get Info")
                        .font(.headline3)
                        .foregroundColor(.basicWhite)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blueMain)
                        .cornerRadius(10)
                }
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(
                        title: Text("Alert error"),
                        message: Text("Wrong IP! Please provide a valid IP address"),
                        primaryButton: .default(Text("OK"), action: {
                            viewModel.clearIP()
                        }),
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }
                
                Button(action: {
                    Task {
                        viewModel.isLoading = true
                        let fetchedIP = await viewModel.fetchUserIP()
                        viewModel.ipAddress = fetchedIP ?? ""
                        viewModel.isValid = true
                        viewModel.isLoading = false
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
                    viewModel.clearIP()
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
            
            if viewModel.isLoading {
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
}
