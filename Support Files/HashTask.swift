//
//  HashTask.swift
//  Roommates
//
//  Created by Matt Novoselov on 01/03/24.
//

import Foundation

func currentGMTDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.string(from: Date())
}

func hashTaskExecutor(taskName: String, roommatesList:[String]) -> String {
    if roommatesList.count == 0{
        return "Name N/A"
    }

    let formattedString = String("\(currentGMTDate()) \(taskName)")
    let hashValue = formattedString.hash
    let absHash = abs(hashValue)
    
    // Map hash value to the range
    let mappedValue = absHash % roommatesList.count
    
    let selectedRoommate = roommatesList[mappedValue]
    return selectedRoommate
}
