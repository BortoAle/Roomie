//
//  RoommatesApp.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 15/02/24.
//

import SwiftUI
import CloudKit
import CoreData

@main
struct RoommatesApp: App {
    // Delegate for handling UIApplication lifecycle events
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate

    // App storage property for managing onboarding state
    @AppStorage("isOnboarding")
    private var isOnboarding = true

    // Access to CoreData persistent container
    private let container = CoreDataStack.shared.persistentContainer

    // AppState instance to track the currently selected house
    private let appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Present onboarding view
                .fullScreenCover(isPresented: $isOnboarding, content: {
                    OnboardingView()
                })
                // Provide managed object context to ContentView
                .environment(\.managedObjectContext, container.viewContext)
                // Provide app state to ContentView
                .environment(appState)
        }
    }
}
