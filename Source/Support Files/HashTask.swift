//
//  HashTask.swift
//  Roommates
//
//  Created by Matt Novoselov on 01/03/24.
//

import Foundation

// Function to get the current date in GMT timezone as a string
func currentGMTDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = "yyyy-MM-dd"

    return dateFormatter.string(from: Date())
}

// Function to select a task executor based on the task name and, list of roommates and current date
func hashTaskExecutor(taskName: String, roommatesList: [String]) -> String {
    // Check if the roommates list is empty
    if roommatesList.isEmpty {
        return "Name N/A" // Return a default value
    }

    // Get current GMT date and the task name into a formatted string
    let formattedString = String("\(currentGMTDate()) \(taskName)")

    // Calculate the hash value of the formatted string
    let hashValue = formattedString.hash

    // Get the absolute value of the hash value
    let absHash = abs(hashValue)

    // Map the hash value to the range of indices of the roommates list
    let mappedValue = absHash % roommatesList.count

    // Select the roommate who will be executing the task
    let selectedRoommate = roommatesList[mappedValue]

    return selectedRoommate
}
