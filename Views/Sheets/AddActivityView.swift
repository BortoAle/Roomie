//
//  AddActivityView.swift
//  Roommates
//
//  Created by Suyeon Cho on 16/02/24.
//

import SwiftUI

struct AddActivityView: View {
	@Environment(\.presentationMode) var presentationMode
	@Environment(\.managedObjectContext) private var viewContext
	@Environment(AppState.self) var appState
	
	@State var activityName: String = ""
	@FocusState private var fieldIsFocused: Bool
	@State private var selectedDays: [Int] = []
	
	var body: some View {
		VStack (alignment: .leading){
			HStack{
				Text("New activity")
					.font(.title2)
					.fontWeight(.bold)
				
				Button(action: { presentationMode.wrappedValue.dismiss() }) {
					ExitButtonView()
					
				}
				.frame(width: 24, height: 24)
				.frame(maxWidth: .infinity, alignment: .trailing)
			}
			
			TextField("Enter activity name", text: $activityName)
				.focused($fieldIsFocused)
				.font(.title2)
				.fontWeight(.bold)
				.foregroundColor(.accentColor)
			
			Divider()
				.background(Color.secondary)
				.padding(.bottom)
			
			VStack(alignment: .leading, spacing: 5){
				Text("Days active")
					.font(.title2)
					.fontWeight(.bold)
				
				DaySelectionView(selectedDays: $selectedDays)
					.padding(.bottom)
			}
			
			RectangularButton(text: "Add", color: .accentColor, action: {addActivity(name: activityName)})
				.disabled(activityName.isEmpty)
				.disabled(selectedDays.isEmpty)
			
		}
		.padding()
		.padding(.top)
		.onAppear(){
			fieldIsFocused = true
		}
		
	}
	
	private func addActivity(name: String) {
		withAnimation {
			let newActivity = Activity(context: viewContext)
			newActivity.name = name
			
			chatGPTRequest(inputPrompt: name) { result in
				do {
					let emoji = result?.prefix(1).lowercased() ?? "❌"
					newActivity.emoji = emoji
					try viewContext.save()
				} catch {
					print("Error: \(error)")
				}
			}
			
			newActivity.house = appState.selectedHouse
			do {
				try viewContext.save()
				presentationMode.wrappedValue.dismiss()
			} catch {
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}
}

#Preview {
	AddActivityView()
		.environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
		.environment(AppState())
}
