//
//  HouseCardView.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 01/03/24.
//

import SwiftUI
import CloudKit

struct HouseCardView: View {
	
	@Environment(\.colorScheme) private var colorScheme
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
							.foregroundStyle(.accent)
						
						VStack(alignment: .leading){
							Text(house.name ?? "N/A")
								.font(.headline)
							
							if stack.isShared(object: house) {
								if stack.isOwner(object: house) {
									Text("Created by you")
										.foregroundStyle(.secondary)
								} else {
									Text("Created by \(share?.owner.userIdentity.nameComponents?.givenName ?? "")")
										.foregroundStyle(.secondary)
								}
							}
						}
						
						Spacer()
						
						Button(action: shareAction, label: {
							Label("Share", systemImage: "square.and.arrow.up")
						})
					}
				}
				.padding(.vertical, 8)
			})
		}
		.foregroundStyle(colorScheme == .light ? .black : .white)
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
