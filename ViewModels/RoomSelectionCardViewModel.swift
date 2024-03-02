//
//  RoomSelectionCardViewModel.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import Foundation

class RoomSelectionCardViewModel {
	var roomSelectionCards = [
		RoomSelectionCard(roomName: String(localized: "Kitchen"), roomEmoji: "🍳", activityName: String(localized: "Clean Kitchen")),
		RoomSelectionCard(roomName: String(localized: "Bathroom"), roomEmoji: "🚿", activityName: String(localized: "Clean Bathroom")),
		RoomSelectionCard(roomName: String(localized: "Dining Area"), roomEmoji: "🍽️", activityName: String(localized: "Clean Dining Area")),
		RoomSelectionCard(roomName: String(localized: "Corridor"), roomEmoji: "🚶", activityName: String(localized: "Clean Corridor")),
		RoomSelectionCard(roomName: String(localized: "Entryway"), roomEmoji: "🚪", activityName: String(localized: "Clean Entryway")),
		RoomSelectionCard(roomName: String(localized: "Balcony"), roomEmoji: "🌿", activityName: String(localized: "Clean Balcony")),
		RoomSelectionCard(roomName: String(localized: "Laundry Room"), roomEmoji: "🧺", activityName: String(localized: "Clean Laundry Room")),
		RoomSelectionCard(roomName: String(localized: "Living Room"), roomEmoji: "🛋️", activityName: String(localized: "Clean Living Room")),
		RoomSelectionCard(roomName: String(localized: "Home Office"), roomEmoji: "📠", activityName: String(localized: "Clean Home Office")),
		RoomSelectionCard(roomName: String(localized: "Closet"), roomEmoji: "👔", activityName: String(localized: "Clean Closet"))
	]
}
