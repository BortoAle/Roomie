//
//  RoomSelectionCardViewModel.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import Foundation

class RoomSelectionCardViewModel {
    var roomSelectionCards = [
        RoomSelectionCard(roomName: String(localized: "Kitchen"), roomEmoji: "🍳", activityName: "Clean Kitchen"),
        RoomSelectionCard(roomName: String(localized: "Bathroom"), roomEmoji: "🚿", activityName: "Clean Bathroom"),
        RoomSelectionCard(roomName: String(localized: "Dining Area"), roomEmoji: "🍽️", activityName: "Clean Dining Area"),
        RoomSelectionCard(roomName: String(localized: "Corridor"), roomEmoji: "🚶", activityName: "Clean Corridor"),
        RoomSelectionCard(roomName: String(localized: "Entryway"), roomEmoji: "🚪", activityName: "Clean Entryway"),
        RoomSelectionCard(roomName: String(localized: "Balcony"), roomEmoji: "🌿", activityName: "Clean Balcony"),
        RoomSelectionCard(roomName: String(localized: "Laundry Room"), roomEmoji: "🧺", activityName: "Clean Laundry Room"),
        RoomSelectionCard(roomName: String(localized: "Living Room"), roomEmoji: "🛋️", activityName: "Clean Living Room"),
        RoomSelectionCard(roomName: String(localized: "Home Office"), roomEmoji: "📠", activityName: "Clean Home Office"),
        RoomSelectionCard(roomName: String(localized: "Closet"), roomEmoji: "👔", activityName: "Clean Closet")
    ]
}
