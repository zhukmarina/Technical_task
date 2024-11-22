//
//  IPInfoView.swift
//  technical_task
//
//  Created by Marina Zhukova on 13.11.2024.
//
import SwiftUI
import MapKit

struct IPInfoView: View {
    @Environment(\.dismiss) private var dismiss
    let arrayForIpInfo: [(title: String, value: String)]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                
                ForEach(arrayForIpInfo, id: \.title) { item in
                    
                    HStack {
                        Text(item.title + ":")
                            .frame(width: 100, alignment: .leading)
                        
                        if item.title == "Location" {
                            NavigationLink(destination:
                                            MapScreenView(coordinates: item.value)
                                            .navigationBarTitle(
                                                Text(arrayForIpInfo.first(where: { $0.title == "Region" })?.value ?? "\(item.value)")
                                                    .font(.headline3)
                                                    .foregroundColor(.basicDark)
                                            )
                            ) {
                                Text(item.value)
                                    .foregroundColor(.blueMain)
                                    .underline()
                            }
                            
                        } else if item.title == "Readme", let readmeURL = URL(string: item.value) {
                            Link(destination: readmeURL){
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
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blueGrey))
            .frame(maxWidth: .infinity)
        }
    }
}


