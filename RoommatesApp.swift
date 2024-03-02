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
	@UIApplicationDelegateAdaptor(AppDelegate.self)
	private var appDelegate

	@AppStorage("isOnboarding")
	private var isOnboarding: Bool = true

	private let container = CoreDataStack.shared.persistentContainer
	private let appState = AppState()

	var body: some Scene {
		WindowGroup {
			ContentView()
				.fullScreenCover(isPresented: $isOnboarding, content: {
					OnboardingView()
				})
				.environment(\.managedObjectContext, container.viewContext)
				.environment(appState)
		}
	}
}
