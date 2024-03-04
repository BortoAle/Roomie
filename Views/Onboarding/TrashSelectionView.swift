//
//  TrashSelectionView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import SwiftUI

struct TrashSelectionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(AppState.self) var appState

    @AppStorage("isOnboarding") var isOnboarding = true

    @State private var showingAddActivity = false
    @State private var openedSheetSize: Double = 0

    @State private var suggestedAddActivityName: String = ""

    var viewModel = TrashSelectionCardViewModel()
    @State var amountOfCardsAdded: Int = 0

    var body: some View {
        VStack(alignment: .leading) {
            Text("What trash do you sort?")
                .bold()
                .font(.title2)
                .padding()

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

            RectangularButton(
                text: amountOfCardsAdded == 0 ? "Skip for now" : "Continue",
                color: amountOfCardsAdded == 0 ? .namaraGray : .accentColor,
                action: {
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
