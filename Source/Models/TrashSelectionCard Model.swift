//
//  TrashSelectionCard Model.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import Foundation

// Structure that represents trash selection card for onboarding view
struct TrashSelectionCard: Identifiable {
    var id = UUID()
    var trashName: String
    var trashEmoji: String
    var activityName: String
}
