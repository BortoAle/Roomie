//
//  SingleDayButton.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 02/03/24.
//

import SwiftUI

struct SingleDayButton: View {
	@Binding var selectedDays: [Int]
	var day: DayData
	
	var body: some View {
		
		Button(
			action:{
				if selectedDays.contains(day.weekdayID) {
					withAnimation(){
						selectedDays.removeAll { $0 == day.weekdayID }
					}
				} else {
					withAnimation(){
						selectedDays.append(day.weekdayID)
					}
					
				}
			}
		)
		{
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
					Text(day.initial)
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
