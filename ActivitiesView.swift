//
//  ActivitiesView.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 23/02/24.
//

import SwiftUI
import CloudKit

struct ActivitiesView: View {
	@State private var myFilter = false
	@State private var showingEditActivity = false
	@State private var showingAddActivity = false
	
	@Environment(\.managedObjectContext) private var viewContext
	@Environment(AppState.self) var appState
	
	@State private var openedSheetSize: Double = 0
	
	@FetchRequest private var activities: FetchedResults<Activity>
	@State private var editedActivity: Activity? = nil
	private let share: CKShare?
	
	private let stack = CoreDataStack.shared
	
	init(house: House) {
		share = stack.getShare(house)
		_activities = FetchRequest(entity: Activity.entity(),
								   sortDescriptors: [NSSortDescriptor(keyPath: \Activity.timestamp, ascending: false)],
								   predicate: NSPredicate(format: "%K = %@", #keyPath(Activity.house), house),
								   animation: .default)
	}
	
	var body: some View {
		NavigationStack {
			List{
				Section(){
					ForEach(activities){ activity in
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
					.listRowInsets(EdgeInsets())
					.fontWeight(.bold)
			}
			}
			.padding(.top)
			.sheet(item: $editedActivity, content: { activity in
				EditActivityView(activity: activity)
					.onAppearUpdateHeight($openedSheetSize)
					.presentationDetents([.height(openedSheetSize)])
			})
			.sheet(
				isPresented: $showingAddActivity,
				content: {
					AddActivityView()
						.onAppearUpdateHeight($openedSheetSize)
						.presentationDetents([.height(openedSheetSize)])
				}
			)
			.toolbar(content: {
				ToolbarItem (placement: .navigationBarTrailing){
					Button(action: {
						withAnimation(){
							myFilter.toggle()
						}
					}, label: {
						Image(systemName: myFilter ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
							.fontWeight(.bold)
					})
					.tint(.white)
				}
				
				ToolbarItem (placement: .navigationBarTrailing){
					Button(action: { showingAddActivity=true
					}, label: {
						Image(systemName: "plus")
							.fontWeight(.bold)
					}).tint(.white)
				}
			})
		}
	}
	
	private func canEdit(activity: Activity) -> Bool {
		stack.canEdit(object: activity)
	}
	
}
