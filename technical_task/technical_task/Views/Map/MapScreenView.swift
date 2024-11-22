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
    
    var body: some View {
        let coordinateParts = coordinates.split(separator: ",")
        if coordinateParts.count == 2,
           let latitude = Double(coordinateParts[0]),
           let longitude = Double(coordinateParts[1]) {
            
            MapView(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                .edgesIgnoringSafeArea(.bottom)
//                .navigationBarBackButtonHidden(true)
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button {
//                            dismiss()
//                        } label: {
//                            Image(systemName: "chevron.backward")
//                        }
//                    }
//                }
        } else {
            Text("Invalid coordinates")
                .padding()
        }
    }
}

