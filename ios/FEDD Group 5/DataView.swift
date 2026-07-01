//
//  DataView.swift
//  FEDD Group 5
//

import SwiftUI
import Combine
import Charts

struct DataView: View {
    let HEADER = ["Time", "Group", "North", "South", "East", "West"]
    @State private var data: [[String]] = []
    @State private var locationData: [Int] = [0,0,0,0]
    @EnvironmentObject var masterPedestrianList: DataHandler
    let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Data View")
                .font(.largeTitle)
            Spacer()
            ScrollView {
                Grid(alignment: .leading) {
                    ForEach(data.indices, id: \.self) { rowIndex in
                        GridRow {
                            ForEach(data[rowIndex].indices, id: \.self) { colIndex in
                                Text(data[rowIndex][colIndex])
                            }
                        }
                    }
                }
            }
            Spacer()
            Chart {
                BarMark(
                    x: .value("Direction", "North"),
                    y: .value("Total Count", locationData[0])
                )
                BarMark(
                    x: .value("Direction", "South"),
                    y: .value("Total Count", locationData[1])
                )
                BarMark(
                    x: .value("Direction", "East"),
                    y: .value("Total Count", locationData[2])
                )
                BarMark(
                    x: .value("Direction", "West"),
                    y: .value("Total Count", locationData[3])
                )
            }
            .foregroundStyle(Color(.red))
        }
        .onReceive(timer) { input in
                generate()
        }
    }
    
    func generate() {
        data = []
        data.append(HEADER)
        data.append(contentsOf: masterPedestrianList.pedData)
        locationData = [0,0,0,0]
        for i in 0..<masterPedestrianList.pedData.count {
            locationData[0] += Int(masterPedestrianList.pedData[i][2]) ?? 0
            locationData[1] += Int(masterPedestrianList.pedData[i][3]) ?? 0
            locationData[2] += Int(masterPedestrianList.pedData[i][4]) ?? 0
            locationData[3] += Int(masterPedestrianList.pedData[i][5]) ?? 0
        }
    }
}

#Preview {
    DataView()
}
