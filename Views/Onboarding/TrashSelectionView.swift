//
//  TrashSelectionView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import SwiftUI

struct TrashSelectionView: View {
    
    var viewModel = TrashSelectionCardViewModel()
    @State var amountOfCardsAdded: Int = 0
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("What trash do you sort?")
                    .bold()
                    .font(.title2)
                    .padding()
                
                ScrollView{
                    VStack{
                        ForEach(viewModel.trashSelectionCards){
                            roomSelectionCard in
                            
                            RoomSelectionCardView(roomName: roomSelectionCard.trashName, roomEmoji: roomSelectionCard.trashEmoji, amountOfCardsAdded: $amountOfCardsAdded)
                        }
                    }
                    .padding(.horizontal)
                }
                
                RectangularButton(
                    text: amountOfCardsAdded == 0 ? "Skip for now" : "Continue",
                    color: amountOfCardsAdded == 0 ? .namaraGray : .accentColor
                )
                .padding(.horizontal)
                .padding(.top)
                .overlay(
                    NavigationLink(destination: ContentView()) {
                        Color.clear
                    }
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                .neroGray
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TrashSelectionView()
}
