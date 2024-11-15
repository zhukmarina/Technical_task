//
//  IPInfoView.swift
//  technical_task
//
//  Created by Marina Zhukova on 13.11.2024.
//
import SwiftUI
import MapKit

struct IPInfoView: View {
    let info: DMGetInfo
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("IP:")
                        Text("Hostname:")
                        Text("City:")
                        Text("Region:")
                        Text("Country:")
                        Text("Location:")
                        Text("Organization:")
                        Text("Postal:")
                        Text("Timezone:")
                        Text("Readme:")
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text(info.ip)
                        Text(info.hostname)
                        Text(info.city)
                        Text(info.region)
                        Text(info.country)
                        NavigationLink(destination: MapScreenView(coordinates: info.loc)) {
                            Text(info.loc)
                                .foregroundColor(.blueMain)
                                .underline()
                        }
                        Text(info.org)
                        Text(info.postal)
                        Text(info.timezone)
                        
                        if let readmeURL = URL(string: info.readme) {
                            Link("\(info.readme)", destination: readmeURL)
                                .foregroundColor(.blueMain)
                                
                        } else {
                            Text(info.readme)
                        }
                    }
                }
            }
            .padding()
            .font(.body3)
            .padding(.horizontal)
        }
    }
}
