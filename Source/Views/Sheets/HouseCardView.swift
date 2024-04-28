//
//  HouseCardView.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 01/03/24.
//

import SwiftUI
import CloudKit

// SwiftUI view for displaying a card representing a house
struct HouseCardView: View {
    // Accessing color scheme
    @Environment(\.colorScheme) private var colorScheme

    // Accessing app state environment variable
    @Environment(AppState.self) var appState

    // Accessing dismiss variable to dismiss sheets
    @Environment(\.dismiss) var dismiss

    // House object to display
    let house: House

    // Core Data stack instance
    private let stack = CoreDataStack.shared

    // State variable to store CloudKit share
    @State private var share: CKShare?

    // Action for swiping
    let swipeAction: () -> Void

    // Action to share the house
    let shareAction: () -> Void

    // Body of the view
    var body: some View {
        Section {
            // Button to select the house
            Button(action: {
                appState.selectedHouse = house // Set selected house in app state
                dismiss() // Dismiss the view
            }, label: {
                VStack {
                    HStack {
                        Image(systemName: "house.fill")
                            .fontWeight(.semibold)
                            .font(.title2)

                        VStack(alignment: .leading) {
                            // Display house name
                            Text(house.name ?? "N/A")
                                .font(.headline)

                            // Display creator information if shared
                            if stack.isShared(object: house) {
                                if stack.isOwner(object: house) {
                                    Text("Created by you")
                                        .foregroundStyle(.secondary)
                                } else {
                                    Text("Created by \(share?.owner.userIdentity.nameComponents?.givenName ?? "")")
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }

                        Spacer()

                        // Button to share the house
                        Button(action: shareAction, label: {
                            Image(systemName: "square.and.arrow.up")
                                .fontWeight(.semibold)
                                .accessibility(label: Text("Share"))
                                .foregroundStyle(.accent)
                        })
                    }
                }
                .padding(.vertical, 8)
            })
        }
        // Apply foreground color based on color scheme
        .foregroundStyle(colorScheme == .light ? .black : .white)
        .labelStyle(.iconOnly)
        .imageScale(.large)
        .swipeActions {
            // Swipe action to reveal options
            Button(action: swipeAction, label: {
                Label("", systemImage: "slider.vertical.3")
            })
            .tint(.accentColor)
        }
        // Fetch CloudKit share when view appears
        .onAppear {
            share = stack.getShare(house)
        }
    }
}
