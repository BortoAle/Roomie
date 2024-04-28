//
//  ActivityCardView.swift
//  Roommates
//
//  Created by Matt Novoselov on 20/02/24.
//

import SwiftUI
import CloudKit

struct ActivityCardView: View {
    @Environment(\.managedObjectContext) private var viewContext // Access to the managed object context
    let activity: Activity // The activity displayed on the card
    let showingToggle: Bool // Indicates whether to show a completion toggle
    var emoji: String = "📝" // Emoji representing the activity
    @State var isToggled: Bool // State to track whether the activity is toggled
    private let stack = CoreDataStack.shared // Access to the CoreData stack

    // Share information related to the activity in CloudKit
    private let share: CKShare?
    private var participants: [String] { // Extract participant names from the share
        guard share != nil else { return [] }
        return share!.participants.map({ participant in
            participant.userIdentity.nameComponents?.familyName ?? "Name N/A"
        })
    }

    // Initialize the ActivityCardView with necessary parameters
    init(activity: Activity, showingToggle: Bool, emoji: String, isToggled: Bool) {
        self.activity = activity
        self.showingToggle = showingToggle
        self.emoji = emoji
        self.isToggled = isToggled
        self.share = stack.getShare(activity.house!) // Retrieve share information
    }

    var body: some View {
        HStack(spacing: 15) {
            // Display the emoji representing the activity
            Text(emoji)
                .font(.title2)
                .padding(10)
                .background(
                    ZStack {
                        Color(.white)

                        // Apply color based on the pastel color of the emoji
                        Color(getPastelColor(emoji)).opacity(0.3)
                    }
                )
                .clipShape(Circle())
                .saturation(activity.isCompleted ? 0.5 : 1)

            VStack(alignment: .leading) {
                // Display the name of the activity
                Text(activity.name ?? "")
                    .font(.headline)
                    .fontWeight(.bold)

                HStack(spacing: 5) {
                    // Display icon indicating participants
                    Image(systemName: "person.fill")
                        .imageScale(.small)

                    // Display the hash of task executor based on activity name and participants
                    Text(hashTaskExecutor(taskName: activity.name ?? "", roommatesList: participants))
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.secondary)
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

            if showingToggle {
                // Display a toggle for completing the activity
                Toggle("", isOn: Binding(get: {
                    activity.isCompleted
                }, set: { completionState in
                    activity.isCompleted = completionState
                }))
                .toggleStyle(CheckboxToggleStyle()) // Apply custom toggle style
            }
        }
        // Reduce opacity of completed activities
        .opacity(activity.isCompleted ? 0.4 : 1)

        // Save changes when completion state changes
        .onChange(of: activity.isCompleted) {
            saveActivity()
        }
    }

    // Save activity changes to Core Data
    private func saveActivity() {
        withAnimation {
            do {
                try viewContext.save() // Save changes to the managed object context
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// Custom toggle style for checkboxes
struct CheckboxToggleStyle: ToggleStyle {
    @Environment(\.isEnabled) var isEnabled // Determine if toggle is enabled

    // Create the toggle body
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            withAnimation {
                configuration.isOn.toggle() // Toggle the state
            }
        }, label: {
            ZStack {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .imageScale(.large)
                    .fontWeight(.medium)
                configuration.label
            }
        })
        .buttonStyle(PlainButtonStyle()) // Remove any implicit styling from the button
        .disabled(!isEnabled) // Disable the button if not enabled
    }
}
