//
//  ContentView.swift
//  FEDD Group 5
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTabIndex = 0
    @StateObject var masterPedestrianList = DataHandler()
    var body: some View {
        // Screen Switcher
        TabView(selection: $selectedTabIndex) {
            Tab("Data Collection", systemImage: "figure.walk", value: 0) {
                InputView()
            }
            Tab("Data", systemImage: "chart.bar", value: 1) {
                DataView()
            }
            Tab("Map", systemImage: "map.fill", value: 2) {
                MapView()
            }
            Tab("Import/Export", systemImage: "chart.bar.doc.horizontal", value: 3) {
                DataIO()
            }
        }
        .environmentObject(masterPedestrianList)
    }
}

#Preview {
    ContentView()
}
