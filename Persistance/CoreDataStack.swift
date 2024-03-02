//
//  CoreDataStack.swift
//  CoreDataStack
//
//  Created by Yang Xu on 2021/9/9.
//

import CloudKit
import CoreData
import Foundation

final class CoreDataStack {
	static let shared = CoreDataStack()
	
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
	
	lazy var persistentContainer: NSPersistentCloudKitContainer = {
		let container = NSPersistentCloudKitContainer(name: "Roomie")
		
		let dbURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		
		let privateDesc = NSPersistentStoreDescription(url: dbURL.appendingPathComponent("model.sqlite"))
		privateDesc.configuration = "Private"
		privateDesc.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: ckContainerID)
		privateDesc.cloudKitContainerOptions?.databaseScope = .private
		
		guard let shareDesc = privateDesc.copy() as? NSPersistentStoreDescription else {
			fatalError("Create shareDesc error")
		}
		shareDesc.url = dbURL.appendingPathComponent("share.sqlite")
		let shareDescOption = NSPersistentCloudKitContainerOptions(containerIdentifier: ckContainerID)
		shareDescOption.databaseScope = .shared
		shareDesc.cloudKitContainerOptions = shareDescOption
		
		container.persistentStoreDescriptions = [privateDesc, shareDesc]
		
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
		
		container.viewContext.automaticallyMergesChangesFromParent = true
		container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
		
		do {
			try container.viewContext.setQueryGenerationFrom(.current)
		} catch {
			fatalError("Fail to pin viewContext to the current generation:\(error)")
		}
		
		return container
	}()
	
	let ckContainerID = "iCloud.com.undefined.Roomie"
	
	var ckContainer: CKContainer {
		CKContainer(identifier: ckContainerID)
	}
	
	private var _privatePersistentStore: NSPersistentStore?
	var privatePersistentStore: NSPersistentStore {
		return _privatePersistentStore!
	}
	
	private var _sharedPersistentStore: NSPersistentStore?
	var sharedPersistentStore: NSPersistentStore {
		return _sharedPersistentStore!
	}
	
	var context: NSManagedObjectContext {
		persistentContainer.viewContext
	}
}

extension CoreDataStack {
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
	
	func isShared(object: NSManagedObject) -> Bool {
		isShared(objectID: object.objectID)
	}
	
	func canEdit(object: NSManagedObject) -> Bool {
		return persistentContainer.canUpdateRecord(forManagedObjectWith: object.objectID)
	}
	
	func canDelete(object: NSManagedObject) -> Bool {
		return persistentContainer.canDeleteRecord(forManagedObjectWith: object.objectID)
	}
	
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

extension CoreDataStack {
	func save() {
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				print("ViewContext save error:\(error)")
			}
		}
	}
	
	func addHouse() {
		let house = House(context: context)
		context.perform {
			house.name = "House \(Int.random(in: 1000...2000))"
			//            house.timestamp = Date()
			self.save()
		}
	}
	
	func addActivity(_ house: House) {
		let activity = Activity(context: context)
		context.perform {
			//            activity.note = note
			activity.name = Date().formatted()
			activity.timestamp = Date()
			self.save()
		}
	}
	
	func deleteHouse(_ house: House) {
		context.perform {
			self.context.delete(house)
			self.save()
		}
	}
	
	func deleteActivity(_ activity: Activity) {
		context.perform {
			self.context.delete(activity)
			self.save()
		}
	}
	
	//    func changeMemoText(_ memo: Memo) {
	//        context.perform {
	//            let text = memo.text ?? ""
	//            memo.text = text.appending(String(" \(Int.random(in: 0...9))"))
	//            self.save()
	//        }
	//    }
	
	func delShare(_ share: CKShare?) async {
		guard let share = share else { return }
		do {
			try await ckContainer.privateCloudDatabase.deleteRecord(withID: share.recordID)
		} catch {
			print("Failed to delete ckshare in icloud, error: \(error)")
		}
	}
}
