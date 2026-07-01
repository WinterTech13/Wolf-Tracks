//
//  FileHandler.swift
//  FEDD Group 5
//

import SwiftUI
import UniformTypeIdentifiers
import Foundation

struct FileHandler: FileDocument {
    static var readableContentTypes: [UTType] {
        [.commaSeparatedText, .plainText]
    }
    
    static var writableContentTypes: [UTType] {
        [.commaSeparatedText, .plainText]
    }
    
    var text = ""
    
    init() { }
    
    init(text: String) {
        self.text = text
    }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            let string = String(data: data, encoding: .utf8)
            self.text = string ?? ""
        } else {
            text = ""
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: Data(text.utf8))
    }
}
