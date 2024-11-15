//
//  TextFieldforIP.swift
//  technical_task
//
//  Created by Marina Zhukova on 12.11.2024.
//

import SwiftUI

struct TextFieldforIP: View {
    @Binding var ipAddress: String
    @Binding var isValid: Bool?
    
    var clearIPAction: () -> Void
  
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if ipAddress.isEmpty {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 16))
                        .foregroundColor(.blueMain)
                }
                
                TextField("", text: $ipAddress, prompt: Text("IP Address"))
                   
                    .font(.body3)
                    .foregroundColor(.basicDark )
                    .disableAutocorrection(true)
                    .keyboardType(.numbersAndPunctuation)
                    .onChange(of: ipAddress) { newValue in
                        validateIP(&ipAddress, isValid: &isValid)
                    }

                
                if !ipAddress.isEmpty {
                    Image(systemName: "xmark")
                        .font(.system(size: 16))
                        .foregroundColor(.blueMain)
                        .onTapGesture {
                            clearIPAction()
                        }
                }
            }
            .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isValid == true ? Color.green : (isValid == false ? Color.redMain : Color.blueGrey))
                    )
                }
    }
}


