//
//  AppState.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 23/02/24.
//

import SwiftUI

// Track the currently selected house
@Observable
class AppState {
    var selectedHouse: House?
}
