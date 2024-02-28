//
//  EditActivityView.swift
//  Roommates
//
//  Created by Suyeon Cho on 19/02/24.
//

import SwiftUI

struct EditActivityView: View {
    @Environment(\.dismiss) var dismiss
	@Environment(\.managedObjectContext) private var viewContext
	
    @State private var showingAlert = false
    @State private var activityName: String = ""
    @State private var selectedDays: [Int] = []
	let activity: Activity
    
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Text("Edit activity")
                    .font(.title2)
                    .fontWeight(.bold)
                
				Button(action: dismiss.callAsFunction, label: {
					ExitButtonView()
				})
                .frame(width: 24, height: 24)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            TextField("Enter activity name", text: $activityName)
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
            
            RectangularButton(text: "Delete Activity", color: .redButton, action: {showingAlert = true})
            
			RectangularButton(text: "Save", color: .accentColor, action: {
				saveActivity()
			})
                .disabled(activityName.count == 0)
                .disabled(selectedDays.isEmpty)
            
        }
        .padding()
        .padding(.top)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Do you want to delete this activity completely?"),
                message: Text("You can't undo this action."),
                primaryButton: .cancel(),
                secondaryButton: .destructive(
                    Text("Delete"),
                    action: {}
                )
            )
        }
        
    }
	
	private func saveActivity() {
		withAnimation {
			activity.name = activityName
			do {
				try viewContext.save()
				dismiss()
			} catch {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}
}

#Preview {
	EditActivityView(activity: .mockup)
		.environment(\.managedObjectContext, CoreDataStack.preview.context)
}
