//
//  TrashSelectionCardViewModel.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import Foundation

class TrashSelectionCardViewModel {
    var trashSelectionCards = [
        TrashSelectionCard(trashName: String(localized: "Plastic"), trashEmoji: "🥤", activityName: "Throw Plastic"),
        TrashSelectionCard(trashName: String(localized: "Paper"), trashEmoji: "🗞️️", activityName: "Throw Paper"),
        TrashSelectionCard(trashName: String(localized: "Metal"), trashEmoji: "🥫", activityName: "Throw Metal"),
        TrashSelectionCard(trashName: String(localized: "Organic"), trashEmoji: "🍌", activityName: "Throw Organic"),
        TrashSelectionCard(trashName: String(localized: "Glass"), trashEmoji: "🍾", activityName: "Throw Glass"),
        TrashSelectionCard(trashName: String(localized: "Recyclable"), trashEmoji: "♻️", activityName: "Throw Recyclable"),
        TrashSelectionCard(trashName: String(localized: "Non-Recyclable"), trashEmoji: "🚯", activityName: "Throw Non-Recyclable"),
        TrashSelectionCard(trashName: String(localized: "Oil"), trashEmoji: "🛢️️", activityName: "Throw Oil"),
    ]
}
