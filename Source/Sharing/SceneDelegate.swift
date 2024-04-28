//
//  SceneDelegate.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 27/02/24.
//

import SwiftUI
import CloudKit

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    // Called when the user accepts a CloudKit share
    func windowScene(_ windowScene: UIWindowScene, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata) {
        // Accessing the shared persistent store
        let shareStore = CoreDataStack.shared.sharedPersistentStore

        // Accessing the shared persistent container
        let persistentContainer = CoreDataStack.shared.persistentContainer

        // Accepting the CloudKit share invitation
        persistentContainer.acceptShareInvitations(from: [cloudKitShareMetadata], into: shareStore, completion: { _, error in
            if let error = error {
                print("accepteShareInvitation error :\(error)")
            }
        })
    }
}
