//
//  EditHouseView.swift
//  Roommates
//
//  Created by Matt Novoselov on 29/02/24.
//

import SwiftUI

// View for editing a house
struct EditHouseView: View {
    // Environment variables to hold current appState
    @Environment(AppState.self) var appState

    // Variable to dismiss current sheet
    @Environment(\.dismiss) var dismiss

    // CoreData variable
    @Environment(\.managedObjectContext) private var viewContext

    // State variables
    @State private var showingAlert = false
    @State private var houseName: String = ""
    let house: House
    @FocusState private var fieldIsFocused: Bool

    // Core Data stack instance
    private let stack = CoreDataStack.shared

    var body: some View {
        VStack(alignment: .leading) {
            // Header
            HStack {
                Text("Edit house")
                    .font(.title2)
                    .fontWeight(.bold)

                Button(action: dismiss.callAsFunction, label: {
                    ExitButtonView()
                })
                .frame(width: 24, height: 24)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            // Text field for entering house name
            TextField("Enter house name", text: $houseName)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
                .focused($fieldIsFocused)
                .onAppear {
                    // Load existing house name
                    houseName = house.name ?? ""
                }

            Divider()
                .background(Color.secondary)
                .padding(.bottom)

            // Button to delete the house
            RectangularButton(text: "Delete House", color: .redButton, action: { showingAlert = true })

            // Button to save changes and update the name
            RectangularButton(text: "Save", color: .accentColor, action: {
                saveHouse(name: houseName)
            })
            .disabled(houseName.isEmpty)
        }
        .padding()
        .padding(.top)

        // Focus on text field when view appears
        .onAppear {
            fieldIsFocused = true
        }

        // Alert for confirming deletion of the house
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Do you want to delete this house completely?"),
                message: Text("You can't undo this action."),
                primaryButton: .cancel(),
                secondaryButton: .destructive(
                    Text("Delete"),
                    action: { deleteHouse() }
                )
            )
        }
    }

    // Function to delete the house
    private func deleteHouse() {
        stack.deleteHouse(house)
        appState.selectedHouse = nil
        dismiss()
    }

    // Function to save changes to the house in CloudKit
    private func saveHouse(name: String) {
        withAnimation {
            house.name = houseName

            do {
                try viewContext.save()
                dismiss()
            } catch {
                // Handle save error
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
