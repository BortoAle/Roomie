//
//  AddHouseView.swift
//  Roommates
//
//  Created by Matt Novoselov on 29/02/24.
//

import SwiftUI

struct AddHouseView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(AppState.self) var appState

    @State private var activityName: String = ""
    @FocusState private var fieldIsFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("New house")
                    .font(.title2)
                    .fontWeight(.bold)

                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    ExitButtonView()
                }
                .frame(width: 24, height: 24)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            TextField("Enter house name", text: $activityName)
                .focused($fieldIsFocused)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)

            Divider()
                .background(Color.secondary)
                .padding(.bottom)

            RectangularButton(text: "Add", color: .accentColor, action: { addHouse(name: activityName) })
                .disabled(activityName.isEmpty)
        }
        .padding()
        .padding(.top)
        .onAppear {
            fieldIsFocused = true
        }
    }

    private func addHouse(name: String) {
        withAnimation {
            let newItem = House(context: viewContext)
            newItem.name = name

            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    AddHouseView()
        .environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
        .environment(AppState())
}
