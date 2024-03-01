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
    let formattedString = String("\(currentGMTDate()) \(taskName)")
    print(formattedString)
    let hashValue = formattedString.hash
    let absHash = abs(hashValue)
    
	// Map hash value to the range
	let mappedValue = absHash % (0 - roommatesList.count+1)
    
    let selectedRoommate = roommatesList[mappedValue]
    return selectedRoommate
}
