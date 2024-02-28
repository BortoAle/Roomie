//
//  DaySelectionView.swift
//  Roommates
//
//  Created by Suyeon Cho on 16/02/24.
//

import SwiftUI

struct DayData: Identifiable {
    let id = UUID()
    let name: String
    let initial: String
}

struct DaySelectionView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedDays: [String]
    
    var days: [DayData] {
        _ = Locale.current
        let weekdaySymbols = Calendar.current.standaloneWeekdaySymbols
        return weekdaySymbols.enumerated().map { (index, name) in
            return DayData(name: name, initial: Calendar.current.veryShortWeekdaySymbols[index])
        }
    }
    
    var body: some View {
        HStack{
            ForEach(days, id: \.id) { day in
                SingleDayButton(selectedDays: $selectedDays, day: day)
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(colorScheme == .dark ? .secondary.opacity(0.2) : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        
    }
}

struct SingleDayButton: View {
    @Binding var selectedDays: [String]
    var day: DayData
    
    var body: some View {
        
        Button(
            action:{
                if selectedDays.contains(day.name) {
                    withAnimation(){
                        selectedDays.removeAll { $0 == day.name }
                    }
                } else {
                    withAnimation(){
                        selectedDays.append(day.name)
                    }
                    
                }
            }
        )
        {
            Text("x")
                .foregroundColor(.clear)
                .font(.title3)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    Color(selectedDays.contains(day.name) ? .accentColor : Color.secondary.opacity(0.3))
                )
                .clipShape(Circle())
                .overlay(
                    Text(day.initial)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                )
        }
        
    }
}

#Preview {
    DaySelectionView(selectedDays: .constant([]))
}
