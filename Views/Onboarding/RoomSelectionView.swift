//
//  RoomSelectionView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 20.02.2024.
//

import SwiftUI

struct RoomSelectionView: View {
    
    var viewModel = RoomSelectionCardViewModel()
    
    var body: some View {
        
        ZStack{
            ScrollView{
                VStack {
                    HStack {
                        Text("What rooms do you have?")
                        //                        .fontWeight(.semibold)
                            .bold()
                            .font(.title2)
                            .padding(.leading, 20)
                            .padding(.top, 20)
                            .padding(.bottom, 30)
                        Spacer()
                    }
                    
                    VStack(spacing: 28){
                        ForEach(viewModel.roomSelectionCards){
                            roomSelectionCard in
                            
                            RoomSelectionCardView(roomName: roomSelectionCard.roomName, roomEmoji: roomSelectionCard.roomEmoji, dominantColor: roomSelectionCard.dominantColor)
                        }
                    }
                    RectangularButton(
                        text: "Continue",
                        color: .accentColor
                    )
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            .neroGray
        )
    }
    
}

#Preview {
    RoomSelectionView()
}
