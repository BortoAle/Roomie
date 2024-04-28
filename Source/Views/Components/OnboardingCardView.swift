//
//  OnboardingCardView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 19.02.2024.
//

import SwiftUI

// Card that is used for onboarding in tutorial section
struct OnboardingCardView: View {
    // Main title
    var headerText: LocalizedStringResource

    // Description for the cars
    var descriptionText: LocalizedStringResource

    // Name of the SF Symbol
    var iconName: String

    // Size of the icon
    let iconSize: CGFloat = 40

    var body: some View {
        HStack(spacing: 20) {
            // SF Symbol with fixed size
            Image(systemName: iconName)
                .foregroundColor(.accentColor)
                .font(.system(size: iconSize))
                .fontWeight(.medium)
                .frame(width: iconSize, height: iconSize)

            VStack(alignment: .leading) {
                Text(headerText)
                    .fontWeight(.bold)

                Text(descriptionText)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    OnboardingCardView(headerText: "Hello World", descriptionText: "Sed cupidatat enim occaecat fugiat fugiat ea sint mollit proident ad laborum.", iconName: "xmark")
}
