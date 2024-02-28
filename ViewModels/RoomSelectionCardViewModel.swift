//
//  RoomSelectionCardViewModel.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import Foundation
import SwiftUI

class RoomSelectionCardViewModel{
    
    var roomSelectionCards = [
        RoomSelectionCard(roomName: "Kitchen", roomEmoji: "🍳", dominantColor: Color.yellow),
        RoomSelectionCard(roomName: "Bathroom", roomEmoji: "🚿", dominantColor: Color.blue),
        RoomSelectionCard(roomName: "Dining Area", roomEmoji: "🍽️", dominantColor: Color.gray),
        RoomSelectionCard(roomName: "Corridor", roomEmoji: "🚶", dominantColor: Color.gray),
        RoomSelectionCard(roomName: "Entryway", roomEmoji: "🚪", dominantColor: Color.brown),
        RoomSelectionCard(roomName: "Balcony", roomEmoji: "🌿", dominantColor: Color.green),
        RoomSelectionCard(roomName: "Laundry Room", roomEmoji: "🧺", dominantColor: Color.brown),
        RoomSelectionCard(roomName: "Living Room", roomEmoji: "🛋️", dominantColor: Color.blue),
        RoomSelectionCard(roomName: "Home Office", roomEmoji: "📠", dominantColor: Color.gray),
        RoomSelectionCard(roomName: "Closet", roomEmoji: "👔", dominantColor: Color.blue)
    ]
}
