//
//  DataHandler.swift
//  FEDD Group 5
//

import Foundation
import Combine

class DataHandler: ObservableObject {
    @Published var pedData: [[String]] = []
    @Published var location: String = "Raleigh"
    @Published var notes: String = ""
}

