//
//  AddActivityView.swift
//  Roommates
//
//  Created by Suyeon Cho on 16/02/24.
//

import SwiftUI

// View for adding a new activity
struct AddActivityView: View {
    // Environment variable to dismiss current sheet
    @Environment(\.presentationMode) var presentationMode

    // Environment variable for CloudKit share
    @Environment(\.managedObjectContext) private var viewContext

    // Environment variable that stores current appState
    @Environment(AppState.self) var appState

    // State variable that stores current activity name from the text field
    @State var activityName: String = ""

    // Property that controls if the text field is currently focused
    @FocusState private var fieldIsFocused: Bool

    // Property that stores currently selected days
    @State private var selectedDays: [Int] = []

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("New activity")
                    .font(.title2)
                    .fontWeight(.bold)

                // Exit button to dismiss the current sheet
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    ExitButtonView()
                }
                .frame(width: 24, height: 24)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            // Text field for entering activity name
            TextField("Enter activity name", text: $activityName)
                .focused($fieldIsFocused)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)

            Divider()
                .background(Color.secondary)
                .padding(.bottom)

            // View for selecting days
            VStack(alignment: .leading, spacing: 5) {
                Text("Days active")
                    .font(.title2)
                    .fontWeight(.bold)

                DaySelectionView(selectedDays: $selectedDays)
                    .padding(.bottom)
            }

            // Button for adding the activity
            RectangularButton(text: "Add", color: .accentColor, action: { addActivity(name: activityName) })
                .disabled(activityName.isEmpty)
                .disabled(selectedDays.isEmpty)
        }
        .padding()
        .padding(.top)
        .onAppear {
            fieldIsFocused = true
        }
    }

    // Function to add the activity to CoreData
    private func addActivity(name: String) {
        withAnimation {
            let newActivity = Activity(context: viewContext)
            newActivity.name = name

            // Function to get emoji for the activity
            chatGPTRequest(inputPrompt: name) { result in
                do {
                    let emoji = result?.prefix(1).lowercased() ?? "❌"
                    newActivity.emoji = emoji
                    try viewContext.save()
                } catch {
                    print("Error: \(error)")
                }
            }

            // Function to get emoji for the activity
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
