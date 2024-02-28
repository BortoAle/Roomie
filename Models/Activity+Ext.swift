//
//  Activity+Ext.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 27/02/24.
//

import Foundation

extension Activity {
	static var mockup: Activity {
		let activity = Activity()
		activity.name = "Paper"
		activity.house = House.mockup
		return activity
	}
}
