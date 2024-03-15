//
//  RoomSelectionView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 20.02.2024.
//

import SwiftUI

struct RoomSelectionView: View {
    @Environment(\.managedObjectContext)
    private var viewContext

    @Environment(AppState.self)
    private var appState

    @State private var showingAddActivity = false
    @State private var openedSheetSize: Double = 0

    @State private var suggestedAddActivityName: String = ""

    var viewModel = RoomSelectionCardViewModel()
    @State var amountOfCardsAdded: Int = 0

    var body: some View {
        VStack(alignment: .leading) {
            Text("What rooms do you have?")
                .bold()
                .font(.title2)
                .padding()

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

            RectangularButton(
                text: amountOfCardsAdded == 0 ? "Skip for now" : "Continue",
                color: amountOfCardsAdded == 0 ? .namaraGray : .accentColor
            )
            .onAppear {
                addHouse()
            }
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
        .sheet(
            isPresented: $showingAddActivity,
            content: {
                AddActivityView(activityName: suggestedAddActivityName)
                    .onAppearUpdateHeight($openedSheetSize)
                    .presentationDetents([.height(openedSheetSize)])
            }
        )
    }

    private func addHouse() {
        withAnimation {
            let newItem = House(context: viewContext)
            newItem.name = "My House"
            appState.selectedHouse = newItem

            do {
                try viewContext.save()
            } catch {
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
