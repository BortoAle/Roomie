//
//  ShareController.swift
//  ShareController
//
//  Created by Alessandro Bortoluzzi on 23/02/24.
//

import CloudKit
import Foundation
import SwiftUI
import UIKit

struct CloudSharingView: UIViewControllerRepresentable {
    let share: CKShare
    let container: CKContainer
    let house: House

    func makeCoordinator() -> CloudSharingCoordinator {
        CloudSharingCoordinator.shared
    }

    func makeUIViewController(context: Context) -> UICloudSharingController {
        share[CKShare.SystemFieldKey.title] = house.name
        let controller = UICloudSharingController(share: share, container: container)
        controller.modalPresentationStyle = .formSheet
        controller.delegate = context.coordinator
		context.coordinator.house = house
        return controller
    }

    func updateUIViewController(_ uiViewController: UICloudSharingController, context: Context) {

    }
}

class CloudSharingCoordinator:NSObject,UICloudSharingControllerDelegate{
    func cloudSharingController(_ csc: UICloudSharingController, failedToSaveShareWithError error: Error) {
        print("failed to save share\(error)")
    }

    func itemTitle(for csc: UICloudSharingController) -> String? {
        house?.name
    }

    func cloudSharingControllerDidSaveShare(_ csc: UICloudSharingController){
        
    }

    func cloudSharingControllerDidStopSharing(_ csc: UICloudSharingController){

        guard let house = house else {return}
        if !stack.isOwner(object: house) {
            stack.deleteHouse(house)
            print("Delete local shared data")
        }
        else {
          // CKShare should be deleted
        }
    }
    static let shared = CloudSharingCoordinator()
    let stack = CoreDataStack.shared
    var house: House?
}


