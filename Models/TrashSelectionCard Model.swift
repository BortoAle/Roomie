//
//  TrashSelectionCard Model.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import Foundation
import SwiftUI

struct TrashSelectionCard: Identifiable{
    var id: UUID = UUID()
    var trashName: String
    var trashEmoji: String
    var dominantColor: Color
}
