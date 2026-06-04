//
//  MapView.swift
//  FEDD Group 5
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var locationHandler = LocationManager()
    @State private var latC: Double = 0.0
    @State private var longC: Double = 0.0
    @State private var location: String = "Street"
    @State private var position: MapCameraPosition = .camera(
            MapCamera(
                centerCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                distance: 4000
            )
        )
    @State private var coordPoint = CLLocationCoordinate2D(
        latitude: 0,
        longitude: 0
    )
    var body: some View {
        VStack {
            Text("Map View")
                .font(.largeTitle)
            Spacer()
            Text("Latitude: \(latC)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Longitude: \(longC)")
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text("Location:")
                TextField("", text: $location)
                    .textFieldStyle(.roundedBorder)
            }
            Button("Update") {
                if let currentLocation = locationHandler.location {
                    latC = currentLocation.latitude
                    longC = currentLocation.longitude
                    coordPoint = currentLocation
                    
                    withAnimation {
                        position = .camera(
                            MapCamera(
                                centerCoordinate: currentLocation,
                                distance: 4000
                            )
                        )
                    }
                }
            }
            
            Map(position: $position) {
                Marker("\(location)\n \(coordPoint.latitude), \(coordPoint.longitude)", coordinate: coordPoint)
                    .tint(.red)
            }
            .mapStyle(
                .standard(
                    pointsOfInterest: .excludingAll,
                )
            )
        }
    }
}

#Preview {
    MapView()
}
