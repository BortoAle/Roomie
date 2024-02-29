//
//  EditHouseView.swift
//  Roommates
//
//  Created by Matt Novoselov on 29/02/24.
//

import SwiftUI

struct EditHouseView: View {
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showingAlert = false
    @State private var houseName: String = ""
    let house: House
    
    @FocusState private var fieldIsFocused: Bool
    
    private let stack = CoreDataStack.shared
    
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Text("Edit house")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Button(action: dismiss.callAsFunction, label: {
                    ExitButtonView()
                })
                .frame(width: 24, height: 24)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            TextField("Enter house name", text: $houseName)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
                .focused($fieldIsFocused)
                .onAppear(){
                    houseName = house.name ?? ""
                }
            
            Divider()
                .background(Color.secondary)
                .padding(.bottom)
            
            RectangularButton(text: "Delete House", color: .redButton, action: {showingAlert = true})
            
            RectangularButton(text: "Save", color: .accentColor, action: {
                saveHouse(name: houseName)
            })
                .disabled(houseName.count == 0)
            
        }
        .padding()
        .padding(.top)
        .onAppear(){
            fieldIsFocused = true
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Do you want to delete this house completely?"),
                message: Text("You can't undo this action."),
                primaryButton: .cancel(),
                secondaryButton: .destructive(
                    Text("Delete"),
                    action: {deleteHouse()}
                )
            )
        }
        
    }
    
    private func deleteHouse() {
        stack.deleteHouse(house)
        appState.selectedHouse = nil
        dismiss()
    }
    
    private func saveHouse(name: String) {
        withAnimation {
            house.name = houseName

            do {
                try viewContext.save()
                dismiss()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
