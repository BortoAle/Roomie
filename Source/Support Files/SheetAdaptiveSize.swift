//
//  SheetAdaptiveSize.swift
//  Roommates
//
//  Created by Matt Novoselov on 23/02/24.
//

import SwiftUI

// Extension for SwiftUI's View protocol
extension View {
    // Function to update the height of a sheet when it appears
    func onAppearUpdateHeight(_ openedSheetSize: Binding<Double>) -> some View {
        self.overlay(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        // Update the value of the binding with the height of the overlay
                        openedSheetSize.wrappedValue = proxy.size.height
                    }
            }
        )
    }
}
