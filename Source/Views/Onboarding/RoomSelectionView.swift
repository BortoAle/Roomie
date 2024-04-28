//
//  RoomSelectionView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 20.02.2024.
//

import SwiftUI

// Room selection view offers user a bunch of predefined rooms to add to their cleaning schedule
struct RoomSelectionView: View {
    // Object Context for Core Data
    @Environment(\.managedObjectContext)
    private var viewContext

    // Load current appState to track the currently selected house
    @Environment(AppState.self)
    private var appState

    // Sheet to add new item to the schedule
    @State private var showingAddActivity = false

    // Control the size of currently opened sheet
    @State private var openedSheetSize: Double = 0

    // The name of activity to be added to the sheet element
    @State private var suggestedAddActivityName: String = ""

    // Load predefined cards from the view model
    var viewModel = RoomSelectionCardViewModel()

    // Track an amount of cards that user has selected
    @State var amountOfCardsAdded: Int = 0

    var body: some View {
        VStack(alignment: .leading) {
            Text("What rooms do you have?")
                .bold()
                .font(.title2)
                .padding()

            // Display add card for each activity suggestions
            ScrollView {
                VStack {
                    ForEach(viewModel.roomSelectionCards) {  roomSelectionCard in
                        RoomSelectionCardView(
                            amountOfCardsAdded: $amountOfCardsAdded, roomName: roomSelectionCard.roomName,
                            roomEmoji: roomSelectionCard.roomEmoji,
                            addAction: {
                                suggestedAddActivityName = roomSelectionCard.activityName
                                showingAddActivity = true
                            }
                        )
                    }
                }
                .padding(.horizontal)
            }

            // Button to skip this tutorial element
            RectangularButton(
                text: amountOfCardsAdded == 0 ? "Skip for now" : "Continue",
                color: amountOfCardsAdded == 0 ? .namaraGray : .accentColor
            )
            .padding(.horizontal)
            .padding(.top)
            .overlay(
                NavigationLink(destination: TrashSelectionView()) {
                    Color.clear
                }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            .neroGray
        )

        // Present sheet to add new activity to the schedule
        .sheet(
            isPresented: $showingAddActivity,
            content: {
                AddActivityView(activityName: suggestedAddActivityName)
                    .onAppearUpdateHeight($openedSheetSize)
                    .presentationDetents([.height(openedSheetSize)])
            }
        )

        // Create new house on appear
        .onAppear {
            addHouse()
        }
    }

    // Function to create a new house
    private func addHouse() {
        withAnimation {
            // Create a new instance of the House entity in the Core Data context
            let newItem = House(context: viewContext)

            // Set the name of the new house
            newItem.name = "My House"

            // Update the selected house in the app state to the newly created house
            appState.selectedHouse = newItem

            // Save changes to the Core Data context
            do {
                try viewContext.save()
            } catch {
                // Handle any errors that occur during saving
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    RoomSelectionView()
        .environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
        .environment(AppState())
}
