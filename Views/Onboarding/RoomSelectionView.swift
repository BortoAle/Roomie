//
//  RoomSelectionView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 20.02.2024.
//

import SwiftUI

struct RoomSelectionView: View {
    
    var viewModel = RoomSelectionCardViewModel()
    @State var amountOfCardsAdded: Int = 0
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("What rooms do you have?")
                    .bold()
                    .font(.title2)
                    .padding()
                
                ScrollView{
                    VStack{
                        ForEach(viewModel.roomSelectionCards){  roomSelectionCard in
                            RoomSelectionCardView(roomName: roomSelectionCard.roomName, roomEmoji: roomSelectionCard.roomEmoji, amountOfCardsAdded: $amountOfCardsAdded)
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
                    NavigationLink(destination: TrashSelectionView()) {
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
    RoomSelectionView()
}
