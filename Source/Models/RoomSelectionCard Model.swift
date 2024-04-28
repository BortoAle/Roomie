//
//  RoomSelectionCard Model.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import Foundation

// Structure that represents room selection card for onboarding view
struct RoomSelectionCard: Identifiable {
    var id = UUID()
    var roomName: String
    var roomEmoji: String
    var activityName: String
}
