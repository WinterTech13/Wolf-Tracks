//
//  InputView.swift
//  FEDD Group 5
//

import SwiftUI
import Combine

struct InputView: View {
    @State private var pedestrianList: [Int] = [0,0,0,0]
    @State private var selectedLocation: String = "Raleigh"
    @State private var dataString: String = ""
    @State private var dataList: [String] = []
    @State private var currentDate = Date.now
    @FocusState private var isActive: Bool
    @EnvironmentObject var masterPedestrianList: DataHandler
    let timer = Timer.publish(every: 60.0, on: .main, in: .common).autoconnect()
    let Locations = ["Raleigh", "Prague"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Data Collection")
                .font(.largeTitle)
            Spacer()
            HStack() {
                Text("Last Updated: ")
                Text(dataString.prefix(16))
                    .foregroundColor(.red)
            }
            HStack() {
                Text("Location:")
                // Location Picker
                Menu(selectedLocation) {
                    ForEach(Locations, id: \.self) { location in
                        Button(location, action: {
                            selectedLocation = location
                            masterPedestrianList.location = location
                        })
                    }
                }
            }
            
            // Directions
            HStack(spacing: 30) {
                Text("North")
                Text("South")
                Text("East")
                Text("West")
            }
            
            // Add Buttons
            HStack {
                Button("+", action: {
                    update(dir: 0, amt: 1)
                })
                .buttonStyle(.bordered)
                .tint(.red)
                .controlSize(.large)
                .font(.largeTitle)
                
                Button("+", action: {
                    update(dir: 1, amt: 1)
                })
                .buttonStyle(.bordered)
                .tint(.red)
                .controlSize(.large)
                .font(.largeTitle)
                
                Button("+", action: {
                    update(dir: 2, amt: 1)
                })
                .buttonStyle(.bordered)
                .tint(.red)
                .controlSize(.large)
                .font(.largeTitle)
                
                Button("+", action: {
                    update(dir: 3, amt: 1)
                })
                .buttonStyle(.bordered)
                .tint(.red)
                .controlSize(.large)
                .font(.largeTitle)
            }
            
            // Digit Display
            HStack(spacing: 50) {
                Text(String(pedestrianList[0]))
                    .font(.largeTitle)
                
                Text(String(pedestrianList[1]))
                    .font(.largeTitle)
                
                Text(String(pedestrianList[2]))
                    .font(.largeTitle)
                
                Text(String(pedestrianList[3]))
                    .font(.largeTitle)
            }
            
            // Subtract Buttons
            HStack(spacing: 10) {
                Button("–", action: {
                    update(dir: 0, amt: -1)
                })
                .buttonStyle(.bordered)
                .tint(.red)
                .controlSize(.large)
                .font(.largeTitle)
                
                Button("–", action: {
                    update(dir: 1, amt: -1)
                })
                .buttonStyle(.bordered)
                .tint(.red)
                .controlSize(.large)
                .font(.largeTitle)
                
                Button("–", action: {
                    update(dir: 2, amt: -1)
                })
                .buttonStyle(.bordered)
                .tint(.red)
                .controlSize(.large)
                .font(.largeTitle)
                
                Button("–", action: {
                    update(dir: 3, amt: -1)
                })
                .buttonStyle(.bordered)
                .tint(.red)
                .controlSize(.large)
                .font(.largeTitle)
            }
            Button("Export", action: {
                export()
            })
            Text("Field Notes:")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Notes", text: $masterPedestrianList.notes, axis: .vertical)
                .lineLimit(5...5)
                .focused($isActive)
                .textFieldStyle(.roundedBorder)
            Spacer()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isActive = false
                }
            }
        }
        .padding()
        .onReceive(timer) { input in
            export()
        }
    }
    
    func reset() {
        pedestrianList = [0,0,0,0]
    }
    
    func update(dir: Int, amt: Int) {
        pedestrianList[dir] += amt
        pedestrianList[dir] = max(pedestrianList[dir], 0)
    }
    
    func export() {
        display()
        dataList = dataString.components(separatedBy: ",")
        masterPedestrianList.pedData.append(dataList)
        reset()
    }
    
    func display() {
        dataString = ""
        // Date
        dataString += Date().formatted(
            .dateTime
                .month(.twoDigits)
        ) + "/"
        dataString += Date().formatted(
            .dateTime
                .day(.twoDigits)
        ) + "/"
        dataString += Date().formatted(
            .dateTime
                .year()
        ) + " "
        dataString += Date().formatted(
            .dateTime
                .locale(.init(identifier: "en_UK"))
                .hour(.twoDigits(amPM: .omitted))
        ) + ":"
        dataString += Date().formatted(
            .dateTime
                .minute(.twoDigits)
        )
        
        // Group
        dataString += ",5,"
        
        // Location
        dataString += String(pedestrianList[0]) + ","
        dataString += String(pedestrianList[1]) + ","
        dataString += String(pedestrianList[2]) + ","
        dataString += String(pedestrianList[3])
    }
}

#Preview {
    InputView()
}
