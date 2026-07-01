//
//  DataIO.swift
//  FEDD Group 5
//

import SwiftUI
import UniformTypeIdentifiers

struct DataIO: View {
    @State private var isImportingData = false
    @State private var isImportingNotes = false
    @State private var isExportingData = false
    @State private var isExportingNotes = false
    @State private var isConfirming = false
    @EnvironmentObject var masterPedestrianList: DataHandler
    @State private var document = FileHandler(text: "")
    @State private var data = ""
    @State private var fileName = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Import/Export")
                .font(.largeTitle)
            Spacer()
            
            // Data IO
            Text("Data")
                .font(.title)
            Button("Export", action: {
                data = masterPedestrianList.pedData.map { $0.joined(separator: ",") }.joined(separator: "\n")
                document.text = data
                fileName = masterPedestrianList.location + "_"
                fileName += Date().formatted(
                    .dateTime
                        .month(.twoDigits)
                )
                fileName += Date().formatted(
                    .dateTime
                        .day(.twoDigits)
                )
                fileName += Date().formatted(
                    .dateTime
                        .year()
                )
                
                isExportingData = true
            })
            .fileExporter(
                isPresented: $isExportingData,
                document: document,
                contentType: .commaSeparatedText,
                defaultFilename: fileName
            ) { result in
                switch result {
                case .success(let url):
                    print("Saved to: \(url)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .frame(width: 120, height: 50)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(10)
            
            Button("Import", action: {
                isImportingData = true
            })
            .fileImporter(
                isPresented: $isImportingData,
                allowedContentTypes: [.commaSeparatedText]
            ) { result in
                switch result {
                case .success(let url):
                    let access = url.startAccessingSecurityScopedResource()
                    defer {
                        if access {
                            url.stopAccessingSecurityScopedResource()
                        }
                    }
                    
                    do {
                        let contents = try String(contentsOf: url, encoding: .utf8)
                        data = contents
                        let rows = data.components(separatedBy: "\n")
                        masterPedestrianList.pedData = rows.map { row in
                            row.components(separatedBy: ",")
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .frame(width: 120, height: 50)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(10)
            
            // Text IO
            Text("Notes")
                .font(.title)
            Button("Export", action: {
                data = masterPedestrianList.notes
                document.text = data
                fileName = masterPedestrianList.location + "_"
                fileName += Date().formatted(
                    .dateTime
                        .month(.twoDigits)
                )
                fileName += Date().formatted(
                    .dateTime
                        .day(.twoDigits)
                )
                fileName += Date().formatted(
                    .dateTime
                        .year()
                )
                fileName += "_NOTES"
                
                isExportingNotes = true
            })
            .fileExporter(
                isPresented: $isExportingNotes,
                document: document,
                contentType: .plainText,
                defaultFilename: fileName
            ) { result in
                switch result {
                case .success(let url):
                    print("Saved to: \(url)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .frame(width: 120, height: 50)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(10)
            
            Button("Import", action: {
                isImportingNotes = true
            })
            .fileImporter(
                isPresented: $isImportingNotes,
                allowedContentTypes: [.plainText]
            ) { result in
                switch result {
                case .success(let url):
                    let access = url.startAccessingSecurityScopedResource()
                    defer {
                        if access {
                            url.stopAccessingSecurityScopedResource()
                        }
                    }
                    
                    do {
                        let contents = try String(contentsOf: url, encoding: .utf8)
                        data = contents
                        masterPedestrianList.notes = data
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .frame(width: 120, height: 50)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(10)
            
            // Reset
            Button("Reset Everything", role: .destructive) {
                isConfirming = true
            }
            .confirmationDialog(
                "Reset Data",
                isPresented: $isConfirming,
                titleVisibility: .visible
            ) {
                Button("Yes", role: .destructive) {
                    masterPedestrianList.pedData = []
                    masterPedestrianList.location = "Raleigh"
                    masterPedestrianList.notes = ""
                }
                Button("Cancel") { }
            } message: {
                Text("Are you sure you want to reset the data?")
            }
            Spacer()
        }
    }
}

#Preview {
    DataIO()
}

