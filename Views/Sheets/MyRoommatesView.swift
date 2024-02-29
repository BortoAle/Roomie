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
    
	@FetchRequest(entity: House.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \House.name, ascending: false)], animation: .default)
	private var houses: FetchedResults<House>
	private let stack = CoreDataStack.shared
	
	@State private var showShareController = false
	@State var sharing = false
	@State var sharingHouse: House? = nil
    
	var body: some View {
		NavigationStack {
		List {
			ForEach(houses) { house in
				Section {
					Button(action: {
						appState.selectedHouse = house
					}, label: {
						HStack(spacing: 8) {
							VStack(alignment: .leading) {
								Text(house.name ?? "N/A")
									.font(.headline)
								Text("This is an house description")
							}
							Spacer(minLength: 0)
							if stack.isShared(object: house) {
								if stack.isOwner(object: house) {
									Image(systemName: "person.2.fill")
										.foregroundColor(.blue)
								} else {
									Image(systemName: "person.fill")
										.foregroundColor(.green)
								}
							}
						}
						.padding(.vertical)
						.foregroundStyle(.white)
					})
					.contextMenu(menuItems: {
						Button(action: {
									if isShared(house: house) {
										sharingHouse = house
									} else {
//										openSharingController(house: house)
										Task.detached {
											await createShare(house)
										}
									}
						}, label: {
							Label("Share", systemImage: "square.and.arrow.up")
						})
					})
					.listRowBackground(appState.selectedHouse == house ? Color.blue : .none)
				}
				.labelStyle(.iconOnly)
				.imageScale(.large)
			}
			Button("Add house") {
				addHouse(name: "House")
			}
		}
		.listSectionSpacing(.compact)
		.navigationTitle("Houses")
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) {
				Button("Close") { dismiss() }
			}
		}
		.sheet(item: $sharingHouse, content: { house in
			let share = stack.getShare(house)!
			CloudSharingView(share: share, container: stack.ckContainer, house: house)
				.ignoresSafeArea()
		})
	}
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
		stack.persistentContainer.share([house], to: nil) { _, share, container, error in
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
    
    private func addHouse(name: String) {
        withAnimation {
            let newItem = House(context: viewContext)
            newItem.name = name
            
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
