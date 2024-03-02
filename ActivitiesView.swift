//
//  ActivitiesView.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 23/02/24.
//

import SwiftUI
import CloudKit

struct ActivitiesView: View {
	@Environment(\.managedObjectContext) private var viewContext
	@Environment(AppState.self) private var appState
	
	@FetchRequest private var activities: FetchedResults<Activity>
	
	@State private var myFilter = false
	@State private var showingEditActivity = false
	@State private var showingAddActivity = false
	@State private var openedSheetSize: Double = 0
	@State private var editedActivity: Activity? = nil
	
	private let stack = CoreDataStack.shared
	private let share: CKShare?
	private var participants: [PersonNameComponents] {
		guard share != nil else { return [] }
#warning("Check on person without name")
		return share!.participants.compactMap({ participant in
			participant.userIdentity.nameComponents
		})
	}
	
	init(house: House) {
		share = stack.getShare(house)
		_activities = FetchRequest(entity: Activity.entity(),
								   sortDescriptors: [NSSortDescriptor(keyPath: \Activity.timestamp, ascending: false)],
								   predicate: NSPredicate(format: "%K = %@", #keyPath(Activity.house), house),
								   animation: .default)
	}
	
	var body: some View {
		NavigationStack {
			List {
				Section {
						ForEach(activities) { activity in
							ActivityCardView(activity: activity, showingToggle: true, emoji: activity.emoji ?? "📝", isToggled: activity.isCompleted)
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
			header: {
				Text("Today")
					.headerProminence(.increased)
					.listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
					.fontWeight(.bold)
			}
			}
			.sheet(item: $editedActivity) { activity in
				EditActivityView(activity: activity)
					.onAppearUpdateHeight($openedSheetSize)
					.presentationDetents([.height(openedSheetSize)])
			}
			.sheet(isPresented: $showingAddActivity) {
				AddActivityView()
					.onAppearUpdateHeight($openedSheetSize)
					.presentationDetents([.height(openedSheetSize)])
			}
			.toolbar {
				ToolbarItem (placement: .navigationBarTrailing){
					Button(action: {
						withAnimation(){
							myFilter.toggle()
						}
					}, label: {
						Label("Filter", systemImage: myFilter ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
							.fontWeight(.semibold)
							.labelStyle(.iconOnly)
					})
				}
				
				ToolbarItem (placement: .navigationBarTrailing){
					Button(action: {
						showingAddActivity = true
					}, label: {
						Label("Add Activity", systemImage: "plus")
							.fontWeight(.semibold)
							.labelStyle(.iconOnly)
					})
				}
			}
		}
	}
	
	private func canEdit(activity: Activity) -> Bool {
		stack.canEdit(object: activity)
	}
	
}

#Preview {
	let appState = AppState()
	appState.selectedHouse = .mockup
	
	return ActivitiesView(house: .mockup)
		.environment(\.managedObjectContext, CoreDataStack.preview.context)
		.environment(appState)
}
