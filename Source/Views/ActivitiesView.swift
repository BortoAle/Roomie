//
//  ActivitiesView.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 23/02/24.
//

import SwiftUI
import CloudKit

// ActivitiesView is the main View that displays all activities and it's executors
struct ActivitiesView: View {
    // Access to Core Data managed object context
    @Environment(\.managedObjectContext)
    private var viewContext

    // Access to custom environment object AppState
    @Environment(AppState.self) private var appState

    // Fetch activities from Core Data
    @FetchRequest private var activities: FetchedResults<Activity>

    // State variable to toggle a filter to display only tasks of the current user
    @State private var myFilter = false

    // State variables to manage presentation of sheet views
    @State private var showingEditActivity = false
    @State private var showingAddActivity = false

    // State variable to manage size of opened sheet
    @State private var openedSheetSize: Double = 0

    // State variable to hold the currently edited activity
    @State private var editedActivity: Activity?

    // Core Data stack and CloudKit share
    private let stack = CoreDataStack.shared
    private let share: CKShare?

    // Computed property to extract participants' names from CloudKit share
    private var participants: [PersonNameComponents] {
        guard share != nil else { return [] }
        return share!.participants.compactMap({ participant in
            participant.userIdentity.nameComponents
        })
    }

    // Initialize the view with a house object
    init(house: House) {
        // Fetch CloudKit share for the given house
        share = stack.getShare(house)

        // Fetch activities related to the given house from Core Data
        _activities = FetchRequest(entity: Activity.entity(),
                                   sortDescriptors: [NSSortDescriptor(keyPath: \Activity.timestamp, ascending: false)],
                                   predicate: NSPredicate(format: "%K = %@", #keyPath(Activity.house), house),
                                   animation: .default)
    }


    var body: some View {
        NavigationStack {
            List {
                Section {
                    // Display all current activities in the view
                    ForEach(activities) { activity in
                        ActivityCardView(activity: activity, showingToggle: true, emoji: activity.emoji ?? "📝", isToggled: activity.isCompleted)
                            // Each Activity in the kist can be swiped to be edited
                            .swipeActions {
                                Button {
                                    editedActivity = activity
                                }
                                label: {
                                    Label("Edit", systemImage: "slider.vertical.3")
                                }
                                .tint(.accentColor)
                            }
                    }
                }
                // Title of the list that displays the date the task is assigned to
                // TODO: Display schedule for other days
                header: {
                    Text("Today")
                        .headerProminence(.increased)
                        .listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                        .fontWeight(.bold)
                }
            }

            // Present sheet to edit activity's properties
            .sheet(item: $editedActivity) { activity in
                EditActivityView(activity: activity)
                    .onAppearUpdateHeight($openedSheetSize)
                    .presentationDetents([.height(openedSheetSize)])
            }

            // Present sheet to add new activity
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView()
                    .onAppearUpdateHeight($openedSheetSize)
                    .presentationDetents([.height(openedSheetSize)])
            }

            // Toolbar that appears on the top of the current View
            .toolbar {
                // Filter button that displays only your tasks in the current View
                // TODO: Finish filter sorting
                //                ToolbarItem(placement: .navigationBarTrailing) {
                //                    Button(action: {
                //                        withAnimation {
                //                            myFilter.toggle()
                //                        }
                //                    }, label: {
                //                        Image(systemName: myFilter ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                //                            .fontWeight(.semibold)
                //                            .accessibility(label: Text("Filter"))
                //                    })
                //                }

                // Add button to create new activity and add it to the schedule
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddActivity = true
                    }, label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                            .accessibility(label: Text("Add Activity"))
                    })
                }
            }
        }
    }

    private func canEdit(activity: Activity) -> Bool {
        stack.canEdit(object: activity)
    }
}
