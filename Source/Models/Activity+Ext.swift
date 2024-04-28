//
//  Activity+Ext.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 27/02/24.
//

import Foundation

// Mockup for activity CloudKit sync test
extension Activity {
    var weekdaysIndex: [Int] {
        var days = [Int].init()
        if let weekdays {
            days = weekdays.compactMap { char in
                if let charInt = char.wholeNumberValue {
                    return charInt
                } else {
                    return nil
                }
            }
        }
        return days
    }

    static var mockup: Activity {
        let activity = Activity()
        activity.name = "Paper"
        activity.house = House.mockup
        return activity
    }
}
