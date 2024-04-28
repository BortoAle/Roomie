//
//  LoadTxtFile.swift
//  Roommates
//
//  Created by Matt Novoselov on 15/02/24.
//

import Foundation

// Function to load contents of a file
func loadFileContents(nameOfFileToLoad: String) -> String {
    // Check if the file exists in the project
    if let filePath = Bundle.main.path(forResource: nameOfFileToLoad, ofType: "txt") {
        do {
            // Read contents of the file
            let contents = try String(contentsOfFile: filePath)
            return contents // Return the contents if successful
        } catch {
            // Return error if reading fails
            return "Error reading contents of file: \(error)"
        }
    } else {
        // Return error if file does not exist
        return "File not found."
    }
}
