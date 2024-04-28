//
//  MyRoommatesView.swift
//  Roommates
//
//  Created by Matt Novoselov on 20/02/24.
//

import SwiftUI
import CloudKit
import CoreData

// This struct represents a view to display information about the houses that are available to the user
struct MyRoommatesView: View {
    // Environment variable to access the app's state
    @Environment(AppState.self) var appState

    // Environment variable to access the managed object context
    @Environment(\.managedObjectContext) private var viewContext

    // Environment variable to dismiss the view
    @Environment(\.dismiss) var dismiss

    // State variables to manage the visibility of sheets and their size
    @State private var showingAddHouseSheet = false
    @State private var showingEditHouseSheet = false
    @State private var openedSheetSize: Double = 0

    // Fetch request to retrieve houses from Core Data
    @FetchRequest(entity: House.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \House.name, ascending: false)], animation: .default)
    private var houses: FetchedResults<House>
    private let stack = CoreDataStack.shared

    // State variables to manage sharing and editing of houses
    @State private var showShareController = false
    @State var sharing = false
    @State var sharingHouse: House?
    @State var editingHouse: House?

    var body: some View {
        NavigationStack {
            ZStack {
                // If user deleted or doesn't have any houses, present ContentUnavailableView
                if houses.isEmpty {
                    VStack {
                        ContentUnavailableView("No Houses", systemImage: "house.fill", description: Text("Create a new house"))
                    }
                } else {
                    // Display a list of all houses that the user has access to
                    List {
                        ForEach(houses) { house in
                            // Display a card view for each house
                            HouseCardView(
                                house: house,
                                swipeAction: {
                                    // Set the current house as the one being edited and show the edit sheet
                                    editingHouse = house
                                    showingEditHouseSheet = true
                                },
                                shareAction: {
                                    // Check if the house is already shared
                                    if isShared(house: house) {
                                        // Set the current house as the one being shared
                                        sharingHouse = house
                                    } else {
                                        // If the house is not yet shared, asynchronously create a share
                                        Task.detached {
                                            await createShare(house)
                                        }
                                    }
                                }
                            )
                        }
                    }
                    .listSectionSpacing(.compact)
                }
            }
            .navigationTitle("My Houses")
            .navigationBarTitleDisplayMode(.inline)

            // Toolbar items that are presented on the top
            .toolbar {
                // Button to dismiss current sheet
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: dismiss.callAsFunction) {
                        Text("Done")
                            .font(.headline)
                    }
                }

                // Plus button to add a new house
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddHouseSheet = true
                    }, label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                            .accessibility(label: Text("Add House"))
                    })
                }
            }

            // Present sheet to share house with other people
            .sheet(item: $sharingHouse, content: { house in
                let share = stack.getShare(house)!
                CloudSharingView(share: share, container: stack.ckContainer, house: house)
                    .ignoresSafeArea()
            })
        }

        // Present sheet to ad new house
        .sheet(
            isPresented: $showingAddHouseSheet,
            content: {
                AddHouseView()
                    .onAppearUpdateHeight($openedSheetSize)
                    .presentationDetents([.height(openedSheetSize)])
            }
        )

        // Present sheet to edit the house name or delete it
        .sheet(item: $editingHouse, content: { house in
            EditHouseView(house: house)
                .onAppearUpdateHeight($openedSheetSize)
                .presentationDetents([.height(openedSheetSize)])
        })
    }

    // Function to open sharing controller
    private func openSharingController(house: House) {
        // Get the key window of the application
        let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }.first

        // Retrieve the share and container objects for the given house
        let shareContainer: (CKShare?, CKContainer?) = starSharing(house: house)
        if let share = shareContainer.0, let container = shareContainer.1 {
            // Create a UICloudSharingController with the share and container, and present it
            let sharingController1 = UICloudSharingController(share: share, container: container)
            keyWindow?.rootViewController?.present(sharingController1, animated: true)
        }
    }

    func starSharing(house: House) -> (CKShare?, CKContainer?) {
        var newShare: CKShare?
        var newContainer: CKContainer?
        // Share the given house using CloudKit
        stack.persistentContainer.share([house], to: nil) { _, share, container, _ in
            if let actualShare = share {
                // Set the title of the share to the name of the house
                house.managedObjectContext?.performAndWait {
                    actualShare[CKShare.SystemFieldKey.title] = house.name
                    newShare = share
                    newContainer = container
                }
            }
        }
        // Return the share and container objects
        return (newShare, newContainer)
    }

    // Check if the given house is shared
    private func isShared(house: House) -> Bool {
        stack.isShared(object: house)
    }

    // Check if the user can edit the given shared house
    private func canEdit(house: House) -> Bool {
        stack.canEdit(object: house)
    }

    func createShare(_ house: House) async {
        sharing = true
        do {
            // Share the house asynchronously
            let (_, share, _) = try await stack.persistentContainer.share([house], to: nil)
            // Set the title of the share to the name of the house
            share[CKShare.SystemFieldKey.title] = house.name
        } catch {
            // If sharing fails
            print("Failed to create share")
            sharing = false
        }
        sharing = false
        sharingHouse = house
    }

    // Function to delete the house
    private func deleteHouse(offsets: IndexSet) {
        withAnimation {
            // Delete the houses at the specified offsets
            offsets.map { houses[$0] }.forEach(viewContext.delete)

            do {
                // Save the changes to the Core Data context
                try viewContext.save()
            } catch {
                // If saving fails, handle the error
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    MyRoommatesView()
        .environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
        .environment(AppState())
}
