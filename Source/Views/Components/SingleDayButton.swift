//
//  SingleDayButton.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 02/03/24.
//

import SwiftUI

struct SingleDayButton: View {
    @Binding var selectedDays: [Int] // Binding to track selected days
    var day: DayData // Data for each day

    var body: some View {
        Button(
            action: {
                // Toggle selection of the day
                if selectedDays.contains(day.weekdayID) {
                    // If the day is already selected, remove it
                    withAnimation {
                        selectedDays.removeAll { $0 == day.weekdayID }
                    }
                } else {
                    // If the day is not selected, add it
                    withAnimation {
                        selectedDays.append(day.weekdayID)
                    }
                }
            }
        ) {
            // Display the button with dynamic styling based on selection
            Text(" ")
                .foregroundColor(.clear)
                .font(.title3)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    Color(selectedDays.contains(day.weekdayID) ? .accentColor : Color.secondary.opacity(0.3))
                )
                .clipShape(Circle())
                .overlay(
                    Text(day.initial) // Display the initial of the day inside the button
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                )
        }
    }
}

#Preview {
    SingleDayButton(selectedDays: .constant([0, 1, 4]), day: .init(name: "", initial: "", weekdayID: 0))
}
