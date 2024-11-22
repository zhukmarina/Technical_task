//
//  TextFieldforIP.swift
//  technical_task
//
//  Created by Marina Zhukova on 12.11.2024.
//

import SwiftUI

struct TextFieldforIP: View {
    
    @StateObject private var viewModel = UserInfoModels()
    
    @Binding var ipAddress: String
    @Binding var isValid: Bool?
    
    var clearIPAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if ipAddress.isEmpty {
                    
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blueMain)
                    
                }
                
                TextField("", text: $ipAddress, prompt: Text("IP Address"))
                
                    .font(.body3)
                    .foregroundColor(.basicDark )
                    .disableAutocorrection(true)
                    .keyboardType(.numbersAndPunctuation)
                    .onChange(of: ipAddress) { newValue in
                        viewModel.validateIP(&ipAddress, isValid: &isValid)
                    }
                
                
                if !ipAddress.isEmpty {
                    Image(systemName: "xmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blueMain)
                        .onTapGesture {
                            clearIPAction()
                        }
                }
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isValid == true ? Color.green : (ipAddress.isEmpty ? Color.blueGrey : Color.redMain))
            )
        }
    }
}


