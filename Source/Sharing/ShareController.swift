//
//  ShareController.swift
//  ShareController
//
//  Created by Alessandro Bortoluzzi on 23/02/24.
//

import CloudKit
import SwiftUI
import UIKit

// View representing a cloud sharing interface
struct CloudSharingView: UIViewControllerRepresentable {
    let share: CKShare // The CloudKit share object
    let container: CKContainer // The CloudKit container
    let house: House // The house object to be shared

    // Creates and returns the coordinator object
    func makeCoordinator() -> CloudSharingCoordinator {
        CloudSharingCoordinator.shared
    }

    // Creates and returns the cloud sharing view controller
    func makeUIViewController(context: Context) -> UICloudSharingController {
        // Set the title of the share
        share[CKShare.SystemFieldKey.title] = "Join \(house.name ?? "shared house")"
        // Create the cloud sharing controller with the share and container
        let controller = UICloudSharingController(share: share, container: container)
        controller.modalPresentationStyle = .formSheet
        // Set available permissions for the share
        controller.availablePermissions = [.allowPrivate, .allowReadWrite]
        // Set the coordinator as the delegate
        controller.delegate = context.coordinator
        // Pass the house object to the coordinator
        context.coordinator.house = house
        return controller
    }

    // Updates the cloud sharing view controller
    func updateUIViewController(_ uiViewController: UICloudSharingController, context: Context) {
    }
}

// Coordinator class for the cloud sharing view controller
class CloudSharingCoordinator: NSObject, UICloudSharingControllerDelegate {
    // Function called when failed to save the share
    func cloudSharingController(_ csc: UICloudSharingController, failedToSaveShareWithError error: Error) {
        print("failed to save share\(error)")
    }

    // Function to provide the title for the cloud sharing controller
    func itemTitle(for csc: UICloudSharingController) -> String? {
        house?.name
    }

    // Function called when the share is successfully saved
    func cloudSharingControllerDidSaveShare(_ csc: UICloudSharingController) {
    }

    // Function called when sharing is stopped
    func cloudSharingControllerDidStopSharing(_ csc: UICloudSharingController) {
        guard let house = house else {return}
        if !stack.isOwner(object: house) {
            stack.deleteHouse(house)
            print("Delete local shared data")
        } else {
            // CKShare should be deleted
        }
    }

    // Shared instance of the coordinator
    static let shared = CloudSharingCoordinator()
    let stack = CoreDataStack.shared
    var house: House?
}
