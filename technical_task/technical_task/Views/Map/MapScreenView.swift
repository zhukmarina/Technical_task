//
//  MapScreenView.swift
//  technical_task
//
//  Created by Marina Zhukova on 14.11.2024.
//
import SwiftUI
import MapKit

struct MapScreenView: View {

    @Environment(\.dismiss) private var dismiss
    let coordinates: String
    let region: String
    
    var body: some View {
        let coordinateParts = coordinates.split(separator: ",")
        if coordinateParts.count == 2,
           let latitude = Double(coordinateParts[0]),
           let longitude = Double(coordinateParts[1]) {
            
            MapView(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                                        Text(region)
                                            .font(.headline3)
                                            .foregroundColor(.basicDark)
                                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .font(.body1)
                                .foregroundColor(.basicDark)
                        }
                        
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            
          
         
        } else {
            Text("Invalid coordinates")
                .padding()
        }
    }
}

