//
//  TrashSelectionView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import SwiftUI

struct TrashSelectionView: View {
    // Object Context for Core Data
    @Environment(\.managedObjectContext)
    private var viewContext

    // Load current appState to track the currently selected house
    @Environment(AppState.self)
    private var appState

    // Access App Storage value to control onboarding completion state
    @AppStorage("isOnboarding") var isOnboarding = true

    // Sheet to add new item to the schedule
    @State private var showingAddActivity = false

    // Control the size of currently opened sheet
    @State private var openedSheetSize: Double = 0

    // The name of activity to be added to the sheet element
    @State private var suggestedAddActivityName: String = ""

    // Load predefined cards from the view model
    var viewModel = TrashSelectionCardViewModel()

    // Track an amount of cards that user has selected
    @State var amountOfCardsAdded: Int = 0

    var body: some View {
        VStack(alignment: .leading) {
            Text("What trash do you sort?")
                .bold()
                .font(.title2)
                .padding()

            // Display add card for each activity suggestions
            ScrollView {
                VStack {
                    ForEach(viewModel.trashSelectionCards) {
                        trashSelectionCard in

                        RoomSelectionCardView(
                            amountOfCardsAdded: $amountOfCardsAdded, roomName: trashSelectionCard.trashName,
                            roomEmoji: trashSelectionCard.trashEmoji,
                            addAction: {
                                suggestedAddActivityName = trashSelectionCard.activityName
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
                color: amountOfCardsAdded == 0 ? .namaraGray : .accentColor,
                action: {
                    // Finish onboarding
                    isOnboarding = false
                }
            )
            .padding(.horizontal)
            .padding(.top)
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
    }
}

#Preview {
    TrashSelectionView()
        .environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
        .environment(AppState())
}
