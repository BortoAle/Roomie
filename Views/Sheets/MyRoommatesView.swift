//
//  MyRoommatesView.swift
//  Roommates
//
//  Created by Matt Novoselov on 20/02/24.
//

import SwiftUI
import CloudKit
import CoreData

struct MyRoommatesView: View {
    @Environment(AppState.self) var appState
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @State private var showingAddHouseSheet = false
    @State private var showingEditHouseSheet = false
    @State private var openedSheetSize: Double = 0

    @FetchRequest(entity: House.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \House.name, ascending: false)], animation: .default)
    private var houses: FetchedResults<House>
    private let stack = CoreDataStack.shared

    @State private var showShareController = false
    @State var sharing = false
    @State var sharingHouse: House?
    @State var editingHouse: House?

    @AppStorage("isOnboarding") var isOnboarding: Bool?

    var body: some View {
        NavigationStack {
            ZStack {
                if houses.isEmpty {
                    VStack {
                        Button("Reset onboarding") {
                            isOnboarding = true
                        }

                        ContentUnavailableView("No Houses", systemImage: "house.fill", description: Text("Create a new house"))
                    }
                } else {
                    List {
                        ForEach(houses) { house in
                            HouseCardView(
                                house: house,
                                swipeAction: {
                                    editingHouse = house
                                    showingEditHouseSheet = true
                                },
                                shareAction: {
                                    if isShared(house: house) {
                                        sharingHouse = house
                                    } else {
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: dismiss.callAsFunction) {
                        Text("Done")
                            .font(.headline)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddHouseSheet = true
                    }, label: {
                        Label("Add House", systemImage: "plus")
                            .fontWeight(.semibold)
                    })
                }
            }
            .sheet(item: $sharingHouse, content: { house in
                let share = stack.getShare(house)!
                CloudSharingView(share: share, container: stack.ckContainer, house: house)
                    .ignoresSafeArea()
            })
        }
        .sheet(
            isPresented: $showingAddHouseSheet,
            content: {
                AddHouseView()
                    .onAppearUpdateHeight($openedSheetSize)
                    .presentationDetents([.height(openedSheetSize)])
            }
        )
        .sheet(item: $editingHouse, content: { house in
            EditHouseView(house: house)
                .onAppearUpdateHeight($openedSheetSize)
                .presentationDetents([.height(openedSheetSize)])
        })
    }

    private func openSharingController(house: House) {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }.first

        let shareContainer: (CKShare?, CKContainer?) = starSharing(house: house)
        if let share = shareContainer.0, let container = shareContainer.1 {
            let sharingController1 = UICloudSharingController(share: share, container: container)
            keyWindow?.rootViewController?.present(sharingController1, animated: true)
        }
    }

    func starSharing(house: House) -> (CKShare?, CKContainer?) {
        var newShare: CKShare?
        var newContainer: CKContainer?
        stack.persistentContainer.share([house], to: nil) { _, share, container, _ in
            if let actualShare = share {
                house.managedObjectContext?.performAndWait {
                    actualShare[CKShare.SystemFieldKey.title] = house.name
                    newShare = share
                    newContainer = container
                }
            }
        }
        return(newShare, newContainer)
    }

    private func isShared(house: House) -> Bool {
        stack.isShared(object: house)
    }

    private func canEdit(house: House) -> Bool {
        stack.canEdit(object: house)
    }

    func createShare(_ house: House) async {
        sharing = true
        do {
            let (_, share, _) = try await stack.persistentContainer.share([house], to: nil)
            share[CKShare.SystemFieldKey.title] = house.name
        } catch {
            print("Faile to create share")
            sharing = false
        }
        sharing = false
        sharingHouse = house
    }

    private func deleteHouse(offsets: IndexSet) {
        withAnimation {
            offsets.map { houses[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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
