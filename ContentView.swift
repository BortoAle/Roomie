//
//  ContentView.swift
//  Roommates
//
//  Created by Alessandro Bortoluzzi on 15/02/24.
//

import SwiftUI
import CloudKit

struct ContentView: View {
    @Environment(AppState.self) var appState
    
    @State private var showingMyRoommates = false
    @State private var openedSheetSize: Double = 0
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    var body: some View {
        NavigationStack {
            VStack {
                if let house = appState.selectedHouse{
                    ActivitiesView(house: house)
                } else {
                    ContentUnavailableView("No Houses", systemImage: "house.fill", description: Text("Create a new house"))
                }
            }
            .toolbar{
                ToolbarItem (placement: .navigationBarLeading){
                    
                    Button(action: { showingMyRoommates=true }, label: {
                        Image(systemName: "house.lodge.fill")
                            .fontWeight(.bold)
                    }).tint(.white)
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            isOnboarding = false
        }
        .sheet(
            isPresented: $showingMyRoommates,
            content: {
                MyRoommatesView()
                    .onAppearUpdateHeight($openedSheetSize)
                    .presentationDetents([.large])
            }
        )
        
    }
}


#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
        .environment(AppState())
}
