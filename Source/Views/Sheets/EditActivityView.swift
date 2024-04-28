//
//  EditActivityView.swift
//  Roommates
//
//  Created by Suyeon Cho on 19/02/24.
//

import SwiftUI

// View for editing an existing activity
struct EditActivityView: View {
    // Environment variable to dismiss current sheet
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext

    // Property that controls if the alert is shown
    @State private var showingAlert = false

    // Property that stores activity name from the textfield
    @State private var activityName: String = ""

    // Property that stores currently selected days
    @State private var selectedDays: [Int] = []

    // Variable that holds properties of an Activity
    let activity: Activity

    private let stack = CoreDataStack.shared

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Edit activity")
                    .font(.title2)
                    .fontWeight(.bold)

                // Exit button to dismiss the current sheet
                Button(action: dismiss.callAsFunction, label: {
                    ExitButtonView()
                })
                .frame(width: 24, height: 24)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            // Text field for entering activity name
            TextField("Enter activity name", text: $activityName)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
                .onAppear {
                    activityName = activity.name ?? ""
                }

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

            // Button to delete the activity
            RectangularButton(text: "Delete Activity", color: .redButton, action: { showingAlert = true })

            // Button to save changes
            RectangularButton(text: "Save", color: .accentColor, action: {
                saveActivity()
            })
            .disabled(activityName.isEmpty)
            .disabled(selectedDays.isEmpty)
        }
        .padding()
        .padding(.top)

        // Alert for confirming deletion
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Do you want to delete this activity completely?"),
                message: Text("You can't undo this action."),
                primaryButton: .cancel(),
                secondaryButton: .destructive(
                    Text("Delete"),
                    action: { deleteActivity() }
                )
            )
        }
    }

    // Function to delete the activity
    private func deleteActivity() {
        stack.deleteActivity(activity)
        dismiss()
    }

    // Function to save changes to the activity
    private func saveActivity() {
        withAnimation {
            activity.name = activityName

            // Function to get emoji for the activity
            chatGPTRequest(inputPrompt: activityName) { result in
                do {
                    let emoji = result?.prefix(1).lowercased() ?? "❌"
                    activity.emoji = emoji
                    try viewContext.save()
                } catch {
                    print("Error: \(error)")
                }
            }

            do {
                try viewContext.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
