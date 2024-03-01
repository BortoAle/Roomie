//
//  HouseCardView.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 01/03/24.
//

import SwiftUI
import CloudKit

struct HouseCardView: View {
	
	@Environment(AppState.self) var appState
	@Environment(\.dismiss) var dismiss
	let house: House
	private let stack = CoreDataStack.shared
	@State private var share: CKShare? = nil
	
	let swipeAction: () -> Void
	let shareAction: () -> Void
	
    var body: some View {
		Section {
			Button(action: {
				appState.selectedHouse = house
				dismiss()
				
			}, label: {
				
				VStack {
					HStack{
						Image(systemName: "house.fill")
							.font(.title2)
							.foregroundStyle(.white)
						
						VStack(alignment: .leading){
							Text(house.name ?? "N/A")
								.font(.headline)
							
							if stack.isShared(object: house) {
								if stack.isOwner(object: house) {
									Text("Created by you")
										.foregroundStyle(.gray)
								} else {
									Text("Created by \(share?.owner.userIdentity.nameComponents?.givenName ?? "")")
										.foregroundStyle(.gray)
								}
							}
						}
						.foregroundStyle(.white)
						
						Spacer()
						
						Button(action: shareAction, label: {
							Label("Share", systemImage: "square.and.arrow.up")
						})
					}
//					if let share {
//						ForEach(share.participants, id: \.userIdentity.userRecordID) { participant in
//							if let name = participant.userIdentity.nameComponents {
//								Text(name, format: .name(style: .long))
//							}
//						}
//					}
					
				}
				.padding(.vertical)
				
			})
			
		}
		.labelStyle(.iconOnly)
		.imageScale(.large)
		.swipeActions {
			Button(action: swipeAction, label: {
				Label("", systemImage: "slider.vertical.3")
			})
		.tint(.accentColor)
		}
		.onAppear {
			share = stack.getShare(house)
		}
    }
}

#Preview {
	HouseCardView(house: .mockup, swipeAction: {}, shareAction: {})
}
