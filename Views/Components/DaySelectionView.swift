//
//  DaySelectionView.swift
//  Roommates
//
//  Created by Suyeon Cho on 16/02/24.
//

import SwiftUI

struct DayData: Hashable {
    let name: String
    let initial: String
    let weekdayID: Int
}

struct DaySelectionView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedDays: [Int]
    
    var firstWeekday: Int {
        Calendar.current.firstWeekday
    }
    
    var days: [DayData] {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        
        let weekdaySymbols = Calendar.current.standaloneWeekdaySymbols
        let initialWeekdaySymbols = formatter.veryShortWeekdaySymbols!
        
        // Rearrange the arrays to start from the first weekday
        let rearrangedWeekdaySymbols = Array(weekdaySymbols[firstWeekday-1 ..< weekdaySymbols.count] + weekdaySymbols[0 ..< firstWeekday-1])
        let rearrangedInitialSymbols = Array(initialWeekdaySymbols[firstWeekday-1 ..< initialWeekdaySymbols.count] + initialWeekdaySymbols[0 ..< firstWeekday-1])
        
        return Array(zip(rearrangedWeekdaySymbols, rearrangedInitialSymbols).enumerated().map { (index, pair) in
            let (name, initial) = pair
            let weekdayIndex = (firstWeekday + index - 1) % 7
            return DayData(name: name, initial: initial, weekdayID: weekdayIndex)
        })
    }
    
    var body: some View {
        HStack{
            ForEach(days, id: \.self) { day in
                SingleDayButton(selectedDays: $selectedDays, day: day)
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(colorScheme == .dark ? .secondary.opacity(0.2) : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        
    }
}

#Preview {
    DaySelectionView(selectedDays: .constant([]))
}
