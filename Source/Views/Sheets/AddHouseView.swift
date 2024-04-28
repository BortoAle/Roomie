//
//  AddHouseView.swift
//  Roommates
//
//  Created by Matt Novoselov on 29/02/24.
//

import SwiftUI

// View for adding a new house
struct AddHouseView: View {
    // Value to dismiss the sheet
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext

    // Manage current appState
    @Environment(AppState.self) var appState

    // Selected activity name from the text field
    @State private var activityName: String = ""

    // Property that controls if the text field is focused
    @FocusState private var fieldIsFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            // Header
            HStack {
                Text("New house")
                    .font(.title2)
                    .fontWeight(.bold)

                // Button to dismiss the view
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    ExitButtonView()
                }
                .frame(width: 24, height: 24)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            // Text field for entering house name
            TextField("Enter house name", text: $activityName)
                .focused($fieldIsFocused)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)

            // Divider
            Divider()
                .background(Color.secondary)
                .padding(.bottom)

            // Button to add the new house
            RectangularButton(text: "Add", color: .accentColor, action: { addHouse(name: activityName) })
                .disabled(activityName.isEmpty)
        }
        .padding()
        .padding(.top)

        // Focus on text field when view appears
        .onAppear {
            fieldIsFocused = true
        }
    }

    // Function to add a new house
    private func addHouse(name: String) {
        withAnimation {
            // Create a new House object
            let newItem = House(context: viewContext)
            newItem.name = name

            do {
                // Save changes to the managed object context
                try viewContext.save()
                // Dismiss the view
                presentationMode.wrappedValue.dismiss()
            } catch {
                // Handle save error
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    AddHouseView()
        .environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
        .environment(AppState())
}
