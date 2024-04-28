//
//  AppDelegate.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 27/02/24.
//

import SwiftUI

// AppDelegate class responsible for managing the app's lifecycle events
final class AppDelegate: NSObject, UIApplicationDelegate {
    // Called when connecting to a scene session
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Create a new scene configuration
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)

        // Set the delegate class for the scene configuration to SceneDelegate
        sceneConfig.delegateClass = SceneDelegate.self

        // Return the configured scene configuration
        return sceneConfig
    }
}
