//
//  SheetAdaptiveSize.swift
//  Roommates
//
//  Created by Matt Novoselov on 23/02/24.
//

import SwiftUI

extension View {
    func onAppearUpdateHeight(_ openedSheetSize: Binding<Double>) -> some View {
        self.overlay(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        openedSheetSize.wrappedValue = proxy.size.height
                    }
            }
        )
    }
}
