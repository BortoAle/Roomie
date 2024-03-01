//
//  ActivityCardView.swift
//  Roommates
//
//  Created by Matt Novoselov on 20/02/24.
//

import SwiftUI

struct ActivityCardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let activity: Activity
	let showingToggle: Bool
    var emoji: String = "📝"
	@State var isToggled: Bool
    private let stack = CoreDataStack.shared
    
    var body: some View {
        HStack(spacing: 15){
			Text(emoji)
                .font(.title2)
                .padding(.all, 10)
                .background(
                    ZStack{
                        Color(.white)
                        
						Color(getPastelColor(emoji)).opacity(0.3)
                    }
                )
                .clipShape(Circle())
				.saturation(activity.isCompleted ? 0.5 : 1)
            
            VStack (alignment: .leading){
				Text(activity.name ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                
                HStack (spacing: 5){
                    Image(systemName: "person.fill")
                        .imageScale(.small)
                    
					Text(hashTaskExecutor(taskName: activity.name ?? "", roommatesList: ["Alessandro", "Matt", "Su", "Maria"]))
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.gray)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight:.infinity, alignment:.leading)
            
			if showingToggle {
				Toggle("", isOn: Binding(get: {
					activity.isCompleted
				}, set: { completionState in
					activity.isCompleted = completionState
				}))
                    .toggleStyle(CheckboxToggleStyle())
            }
            
        }
		.opacity(activity.isCompleted ? 0.4 : 1)
		.onChange(of: activity.isCompleted) {
			saveActivity()
		}
    }
    
    private func saveActivity() {
        withAnimation {
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            withAnimation(){
                configuration.isOn.toggle()
            }
        }, label: {
            ZStack {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                configuration.label
            }
        })
        .buttonStyle(PlainButtonStyle()) // remove any implicit styling from the button
        .disabled(!isEnabled)
        
    }
}
