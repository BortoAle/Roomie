//
//  DaySelectionView.swift
//  Roommates
//
//  Created by Suyeon Cho on 16/02/24.
//

import SwiftUI

// Structure to represent Day Data
struct DayData: Hashable {
    // Name of the weekday
    let name: String
    // The day from which the week starts
    let initial: String
    // Id of the weekday, where Sunday = 0, Monday = 1, and etc.
    let weekdayID: Int
}

struct DaySelectionView: View {
    // An array of currently selected Days IDs
    @Binding var selectedDays: [Int]

    // Get user's localized first day of the week as INT
    var firstWeekday: Int {
        Calendar.current.firstWeekday
    }

    var days: [DayData] {
        // Load formatter
        let formatter = DateFormatter()
        formatter.locale = Locale.current

        // Extract short localized symbols that represent first letter of the weekday
        let weekdaySymbols = Calendar.current.standaloneWeekdaySymbols
        let initialWeekdaySymbols = formatter.veryShortWeekdaySymbols!

        // Rearrange the arrays to start from the first weekday
        let rearrangedWeekdaySymbols = Array(weekdaySymbols[firstWeekday - 1 ..< weekdaySymbols.count] + weekdaySymbols[0 ..< firstWeekday - 1])
        let rearrangedInitialSymbols = Array(initialWeekdaySymbols[firstWeekday - 1 ..< initialWeekdaySymbols.count] + initialWeekdaySymbols[0 ..< firstWeekday - 1])

        return Array(zip(rearrangedWeekdaySymbols, rearrangedInitialSymbols).enumerated().map { index, pair in
            let (name, initial) = pair
            let weekdayIndex = (firstWeekday + index - 1) % 7
            return DayData(name: name, initial: initial, weekdayID: weekdayIndex)
        })
    }

    // Display weekday selection button for each weekday
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { day in
                SingleDayButton(selectedDays: $selectedDays, day: day)
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(.neroGray)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

#Preview {
    DaySelectionView(selectedDays: .constant([]))
}
