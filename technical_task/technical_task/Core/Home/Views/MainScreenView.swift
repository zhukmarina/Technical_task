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
            TextFieldforIP
            ButtonView
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else if !viewModel.arrayForIpInfo.isEmpty {
                IpInfoView
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
}


extension MainScreenView{
   
    private var TextFieldforIP: some View {
        VStack(alignment: .leading) {
            HStack {
                if viewModel.ipAddress.isEmpty {
                    
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blueMain)
                    
                }
                
                TextField("", text: $viewModel.ipAddress, prompt: Text("IP Address"))
                
                    .font(.body3)
                    .foregroundColor(.basicDark )
                    .disableAutocorrection(true)
                    .keyboardType(.numbersAndPunctuation)
                    .onChange(of: viewModel.ipAddress) { newValue in
                        viewModel.validateIP(&viewModel.ipAddress, isValid: &viewModel.isValid)
                    }
                
                
                if !viewModel.ipAddress.isEmpty {
                    Image(systemName: "xmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blueMain)
                        .onTapGesture {
                            viewModel.clearIP() 
                        }
                }
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(viewModel.isValid == true ? Color.green : (viewModel.ipAddress.isEmpty ? Color.blueGrey : Color.redMain))
            )
        }
    }
    
    private var ButtonView: some View {
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
        
    }
    
    private var IpInfoView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(viewModel.arrayForIpInfo, id: \.title) { item in
                    HStack {
                        Text(item.title + ":")
                            .frame(width: 100, alignment: .leading)
                        
                        if item.title == "Location" {
                            NavigationLink(
                                destination:
                                    MapScreenView(
                                        coordinates: item.value,
                                        region: viewModel.arrayForIpInfo.first(where: {
                                            $0.title == "Region"
                                        })?.value ?? "Unknown")
                            ) {
                                Text(item.value)
                                    .foregroundColor(.blueMain)
                                    .underline()
                            }
                            
                        } else if item.title == "Readme",
                                  let readmeURL = URL(string: item.value)
                        {
                            Link(destination: readmeURL) {
                                Text(item.value)
                                    .underline()
                                    .foregroundColor(.blueMain)
                            }
                        } else {
                            Text(item.value)
                        }
                        Spacer()
                    }
                    .font(.body3)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10).stroke(Color.blueGrey)
            )
            .frame(maxWidth: .infinity)
        }
    }
    
}
