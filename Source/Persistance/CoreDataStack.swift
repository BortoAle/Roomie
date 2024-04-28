//
//  CoreDataStack.swift
//  CoreDataStack
//
//  Created by Yang Xu on 2021/9/9.
//

import CloudKit
import CoreData
import Foundation

// Class representing the CoreData stack
final class CoreDataStack {
    // Singleton instance of CoreDataStack
    static let shared = CoreDataStack()

    // Initialization
    init() {}

    // A test configuration for SwiftUI previews
    static var preview: CoreDataStack = {
        let controller = CoreDataStack()

        // Create an example list.
        let house1 = House()
        house1.name = "Belluno's home"
        let house2 = House()
        house2.name = "Naples's home"

        let activity1 = Activity()
        activity1.name = "Paper"
        let activity2 = Activity()
        activity2.name = "Waste"
        let activity3 = Activity()
        activity3.name = "Plastic"

        activity1.house = house1
        activity2.house = house2
        activity3.house = house2

        return controller
    }()

    // Lazy initialization of persistent container
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Roomie")

        // Get the URL for the document directory
        let dbURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        // Create private persistent store
        let privateDesc = NSPersistentStoreDescription(url: dbURL.appendingPathComponent("model.sqlite"))
        privateDesc.configuration = "Private"
        privateDesc.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: ckContainerID)
        privateDesc.cloudKitContainerOptions?.databaseScope = .private

        // Create shared persistent store
        guard let shareDesc = privateDesc.copy() as? NSPersistentStoreDescription else {
            fatalError("Create shareDesc error")
        }
        shareDesc.url = dbURL.appendingPathComponent("share.sqlite")
        let shareDescOption = NSPersistentCloudKitContainerOptions(containerIdentifier: ckContainerID)
        shareDescOption.databaseScope = .shared
        shareDesc.cloudKitContainerOptions = shareDescOption

        // Set persistent store descriptions
        container.persistentStoreDescriptions = [privateDesc, shareDesc]

        // Load persistent stores
        container.loadPersistentStores(completionHandler: { desc, err in
            if let err = err as NSError? {
                fatalError("DB init error:\(err.localizedDescription)")
            } else if let cloudKitContiainerOptions = desc.cloudKitContainerOptions {
                switch cloudKitContiainerOptions.databaseScope {
                case .private:
                    self._privatePersistentStore = container.persistentStoreCoordinator.persistentStore(for: privateDesc.url!)
                case .shared:
                    self._sharedPersistentStore = container.persistentStoreCoordinator.persistentStore(for: shareDesc.url!)
                default:
                    break
                }
            }
        })

        // Configure view context
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        do {
            try container.viewContext.setQueryGenerationFrom(.current)
        } catch {
            fatalError("Fail to pin viewContext to the current generation:\(error)")
        }

        return container
    }()

    // CloudKit container identifier
    let ckContainerID = "iCloud.\(Bundle.main.bundleIdentifier ?? "Unknown")"

    // CloudKit container
    var ckContainer: CKContainer {
        CKContainer(identifier: ckContainerID)
    }

    // Private persistent store
    private var _privatePersistentStore: NSPersistentStore?
    var privatePersistentStore: NSPersistentStore {
        return _privatePersistentStore!
    }

    // Shared persistent store
    private var _sharedPersistentStore: NSPersistentStore?
    var sharedPersistentStore: NSPersistentStore {
        return _sharedPersistentStore!
    }

    // View context
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

// Extension for CoreDataStack
extension CoreDataStack {
    // Check if an object's ID is shared
    func isShared(objectID: NSManagedObjectID) -> Bool {
        var isShared = false
        if let persistentStore = objectID.persistentStore {
            if persistentStore == sharedPersistentStore {
                isShared = true
            } else {
                let container = persistentContainer
                do {
                    let shares = try container.fetchShares(matching: [objectID])
                    if shares.first != nil {
                        isShared = true
                    }
                } catch {
                    print("Failed to fetch share for \(objectID): \(error)")
                }
            }
        }
        return isShared
    }

    // Check if an object is shared
    func isShared(object: NSManagedObject) -> Bool {
        isShared(objectID: object.objectID)
    }

    // Check if an object can be edited
    func canEdit(object: NSManagedObject) -> Bool {
        return persistentContainer.canUpdateRecord(forManagedObjectWith: object.objectID)
    }

    // Check if an object can be deleted
    func canDelete(object: NSManagedObject) -> Bool {
        return persistentContainer.canDeleteRecord(forManagedObjectWith: object.objectID)
    }

    // Check if the current user is the owner of a shared object
    func isOwner(object: NSManagedObject) -> Bool {
        guard isShared(object: object) else { return false }
        guard let share = try? persistentContainer.fetchShares(matching: [object.objectID])[object.objectID] else {
            print("Get ckshare error")
            return false
        }
        if let currentUser = share.currentUserParticipant, currentUser == share.owner {
            return true
        }
        return false
    }

    // Get the CKShare object for a shared house
    func getShare(_ house: House) -> CKShare? {
        guard isShared(object: house) else { return nil }
        guard let share = try? persistentContainer.fetchShares(matching: [house.objectID])[house.objectID] else {
            print("Get ckshare error")
            return nil
        }
        share[CKShare.SystemFieldKey.title] = house.name
        return share
    }
}

// Additional functionalities for CoreDataStack
extension CoreDataStack {
    // Save changes in the view context
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("ViewContext save error:\(error)")
            }
        }
    }

    // Add a new house
    func addHouse() {
        let house = House(context: context)
        context.perform {
            house.name = "House \(Int.random(in: 1000...2000))"
            //            house.timestamp = Date()
            self.save()
        }
    }

    // Add a new activity for a house
    func addActivity(_ house: House) {
        let activity = Activity(context: context)
        context.perform {
            //            activity.note = note
            activity.name = Date().formatted()
            activity.timestamp = Date()
            self.save()
        }
    }

    // Delete a house
    func deleteHouse(_ house: House) {
        context.perform {
            self.context.delete(house)
            self.save()
        }
    }

    // Delete an activity
    func deleteActivity(_ activity: Activity) {
        context.perform {
            self.context.delete(activity)
            self.save()
        }
    }

    // Delete a share
    func delShare(_ share: CKShare?) async {
        guard let share = share else { return }
        do {
            try await ckContainer.privateCloudDatabase.deleteRecord(withID: share.recordID)
        } catch {
            print("Failed to delete ckshare in icloud, error: \(error)")
        }
    }
}
