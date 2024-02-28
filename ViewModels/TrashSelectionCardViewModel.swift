//
//  TrashSelectionCardViewModel.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import Foundation
import SwiftUI

class TrashSelectionCardViewModel{
    
    var trashSelectionCards = [
        TrashSelectionCard(trashName: "Plastic", trashEmoji: "🥤", dominantColor: Color.red),
        TrashSelectionCard(trashName: "Paper", trashEmoji: "🗞️️", dominantColor: Color.gray),
        TrashSelectionCard(trashName: "Metal", trashEmoji: "🥫", dominantColor: Color.red),
        TrashSelectionCard(trashName: "Organic", trashEmoji: "🍌", dominantColor: Color.yellow),
        TrashSelectionCard(trashName: "Glass", trashEmoji: "🍾", dominantColor: Color.green),
        TrashSelectionCard(trashName: "Recyclable", trashEmoji: "♻️", dominantColor: Color.green),
        TrashSelectionCard(trashName: "Non-Recyclable", trashEmoji: "🚯", dominantColor: Color.red),
        TrashSelectionCard(trashName: "Oil", trashEmoji: "🛢️️", dominantColor: Color.red),
    ]
}
