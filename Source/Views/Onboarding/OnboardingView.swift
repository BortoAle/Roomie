//
//  OnboardingView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 19.02.2024.
//

import SwiftUI

// Onboarding View is presented when the user first opens the app
struct OnboardingView: View {
    // Animate appearance of the tutorial elements
    @State var animationPhase: Int = 0

    var body: some View {
        NavigationStack {
            VStack {
                // Main title
                Text("Welcome to Roomie")
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 50)
                    // Add phase appearance animation
                    .opacity(animationPhase >= 1 ? 1 : 0)

                // Tutorial elements
                VStack(spacing: 25) {
                    OnboardingCardView(headerText: "Add your roommates", descriptionText: "Create a shared space for coordination and collaboration.", iconName: "person.2")
                        // Add phase appearance animation
                        .opacity(animationPhase >= 2 ? 1 : 0)

                    OnboardingCardView(headerText: "Schedule cleaning", descriptionText: "Set up and organize a cleaning schedule for shared living spaces.", iconName: "bubbles.and.sparkles")
                        // Add phase appearance animation
                        .opacity(animationPhase >= 3 ? 1 : 0)

                    OnboardingCardView(headerText: "Adjust trash schedule", descriptionText: "Customize and adjust reminders for timely trash disposal.", iconName: "trash")
                        // Add phase appearance animation
                        .opacity(animationPhase >= 4 ? 1 : 0)
                }
                .padding(.horizontal, 25)

                Spacer()

                // Button to create a new group
                RectangularButton(
                    text: "Create new group",
                    color: .accentColor)
                    .padding(.horizontal)
                    .overlay(
                        NavigationLink(destination: RoomSelectionView()) {
                            Color.clear
                        }
                    )

                // Button to join already existing group
                RectangularButton(
                    text: "Join group",
                    color: .namaraGray)
                    .padding(.horizontal)
                    .overlay(
                        NavigationLink(destination: JoinGroupView()) {
                            Color.clear
                        }
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.neroGray)

            // Play phase animation for tutorial elements gradual appearance
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { timer in
                    if animationPhase < 4 {
                        withAnimation {
                            animationPhase += 1
                        }
                    } else {
                        timer.invalidate()
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
