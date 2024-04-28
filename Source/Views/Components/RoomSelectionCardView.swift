//
//  RoomSelectionCardView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import SwiftUI

// Card that is used for onboarding to select initial rooms
struct RoomSelectionCardView: View {
    // A total amount of rooms that have already been selected by the user during the tutorial
    @Binding var amountOfCardsAdded: Int

    // Property that controls if the current card is selected by the user
    @State var isSelected = false

    // Name of the room
    var roomName: String

    // Predefined emoji of the room
    var roomEmoji: String

    // Action that happens after clicking on a plus icon
    var addAction: (() -> Void)?

    var body: some View {
        HStack(spacing: 15) {
            // Emoji that describes Room
            Text(roomEmoji)
                .font(.title2)
                .padding(.all, 10)
                .background(
                    ZStack {
                        Color(.white)

                        Color(getPastelColor(roomEmoji)).opacity(0.3)
                    }
                )
                .clipShape(.circle)

            // Main title
            VStack(alignment: .leading) {
                Text(roomName)
                    .font(.headline)
                    .fontWeight(.bold)
            }

            Spacer()

            // Button to perform add action
            Button(action: {
                withAnimation {
                    isSelected.toggle()
                }

                if isSelected {
                    amountOfCardsAdded += 1
                    addAction?()
                }
            }, label: {
                Image(systemName: isSelected ? "plus.circle.fill" : "plus.circle")
                    .font(.title2)
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.onboardingCardGray)
        )
    }
}

#Preview {
    RoomSelectionCardView(amountOfCardsAdded: .constant(0), roomName: "Test", roomEmoji: "❌")
}
