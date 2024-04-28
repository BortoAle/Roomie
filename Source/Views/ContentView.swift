//
//  ContentView.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 15/02/24.
//

import SwiftUI
import CloudKit

struct ContentView: View {
    // Accessing the app's state using Environment to track the currently selected house
    @Environment(AppState.self) private var appState

    // State variable to control the sheet presentation
    @State private var showingMyRoommates = false

    // State variable to manage size of opened sheet
    @State private var openedSheetSize: Double = 0

    var body: some View {
        NavigationStack {
            VStack {
                // Displaying content based on the selected house
                if let house = appState.selectedHouse {
                    ActivitiesView(house: house)
                } else {
                    // If no house is selected, display a message to create a new house
                    ContentUnavailableView("No Houses", systemImage: "house.fill", description: Text("Create a new house"))
                }
            }


            // Adding a toolbar to the navigation bar
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // Button to show My Roommates sheet
                    Button(action: {
                        showingMyRoommates = true
                    }, label: {
                        Image(systemName: "house.lodge")
                            .fontWeight(.semibold)
                            .accessibility(label: Text("Houses settings"))
                    })
                }
            }
        }


        // Presenting a sheet to control participants of the house
        .sheet(
            isPresented: $showingMyRoommates,
            content: {
                // MyRoommatesView presented in a sheet
                MyRoommatesView()
                    // Updating the height of the sheet when it appears
                    .onAppearUpdateHeight($openedSheetSize)
                    .presentationDetents([.large])
            }
        )
    }
}


#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
        .environment(AppState())
}
