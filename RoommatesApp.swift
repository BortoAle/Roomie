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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var appState = AppState()
    let container = CoreDataStack.shared.persistentContainer
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            Group{
                if isOnboarding{
                    OnboardingView()
                }
                else{
                    ContentView()
                }
            }
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, container.viewContext)
            .environment(appState)
        }
    }
}
