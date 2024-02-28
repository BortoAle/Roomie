//
//  LoadTxtFile.swift
//  Roommates
//
//  Created by Matt Novoselov on 15/02/24.
//

import Foundation

func loadFileContents(nameOfFileToLoad: String) -> String {
    if let filePath = Bundle.main.path(forResource: nameOfFileToLoad, ofType: "txt") {
        do {
            let contents = try String(contentsOfFile: filePath)
            return contents
        } catch {
            return "Error reading contents of file: \(error)"
        }
    } else {
        return "File not found."
    }
}
