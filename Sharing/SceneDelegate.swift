//
//  SceneDelegate.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 27/02/24.
//

import SwiftUI
import CloudKit

final class SceneDelegate:NSObject,UIWindowSceneDelegate{
	func windowScene(_ windowScene: UIWindowScene, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata) {
		let shareStore = CoreDataStack.shared.sharedPersistentStore
		let persistentContainer = CoreDataStack.shared.persistentContainer
		persistentContainer.acceptShareInvitations(from: [cloudKitShareMetadata], into: shareStore, completion: { metas,error in
			if let error = error {
				print("accepteShareInvitation error :\(error)")
			}
		})
	}
}
