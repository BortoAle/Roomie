//
//  RectangularButton.swift
//  Roommates
//
//  Created by Mariia Chemerys on 19.02.2024.
//


import SwiftUI

// Rectangular Button is a basic button that is applied to app buttons in the app
struct RectangularButton: View {
    // Pass title for the button
    var text: LocalizedStringResource

    // Pass color of the button
    var color: Color

    // Pass action that should be executed, when clicking on the button
    var action: (() -> Void)?

    var body: some View {
        Button(action: {
            action?()
        }, label: {
            Text(text)
                .font(.title3)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding(.vertical, 3)
                .frame(maxWidth: .infinity)
        })
        .buttonStyle(BorderedProminentButtonStyle())
        .controlSize(.large)
        .tint(color)
    }
}


#Preview {
    RectangularButton(text: "Test Button", color: .accentColor)
}
