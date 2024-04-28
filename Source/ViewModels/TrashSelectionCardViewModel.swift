//
//  TrashSelectionCardViewModel.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import Foundation

// Structure that represents trash selection card for onboarding view
class TrashSelectionCardViewModel {
    var trashSelectionCards = [
        TrashSelectionCard(trashName: String(localized: "Plastic"), trashEmoji: "🥤", activityName: String(localized: "Throw Plastic")),
        TrashSelectionCard(trashName: String(localized: "Paper"), trashEmoji: "🗞️️", activityName: String(localized: "Throw Paper")),
        TrashSelectionCard(trashName: String(localized: "Metal"), trashEmoji: "🥫", activityName: String(localized: "Throw Metal")),
        TrashSelectionCard(trashName: String(localized: "Organic"), trashEmoji: "🍌", activityName: String(localized: "Throw Organic")),
        TrashSelectionCard(trashName: String(localized: "Glass"), trashEmoji: "🍾", activityName: String(localized: "Throw Glass")),
        TrashSelectionCard(trashName: String(localized: "Recyclable"), trashEmoji: "♻️", activityName: String(localized: "Throw Recyclable")),
        TrashSelectionCard(trashName: String(localized: "Non-Recyclable"), trashEmoji: "🚯", activityName: String(localized: "Throw Non-Recyclable")),
        TrashSelectionCard(trashName: String(localized: "Oil"), trashEmoji: "🛢️️", activityName: String(localized: "Throw Oil"))
    ]
}
