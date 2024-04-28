//
//  JoinGroupView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 19.02.2024.
//

import SwiftUI

// JoinGroupView is displayed during onboarding phase, if users selects to join an existing group
struct JoinGroupView: View {
    // Property that becomes true, when the view first appears
    @State private var isLoaded = false

    var body: some View {
        VStack {
            Text("Ask the creator of your group to send you an invitation link")
                .fontWeight(.semibold)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding(.top, 50)

            Spacer(minLength: 0)

            // Animated SF symbol
            Image(systemName: "link")
                .foregroundColor(.accentColor)
                .font(.system(size: 115))
                .symbolEffect(.bounce, value: isLoaded)

                // Set variable to true to play introduction animation
                .onAppear {
                    isLoaded = true
                }

            Spacer()

            // Button to navigate and create group insted
            RectangularButton(
                text: "Create group instead",
                color: .accentColor
            )
            .padding(.horizontal)
            .overlay(
                NavigationLink(destination: RoomSelectionView()) {
                    Color.clear
                }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            .neroGray
        )
    }
}

#Preview {
    JoinGroupView()
}
