//
//  TrashSelectionView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import SwiftUI

struct TrashSelectionView: View {
    
    var viewModel = TrashSelectionCardViewModel()
    
    var body: some View {
        
        ZStack{
            
            VStack {
                HStack {
                    Text("What trash do you sort?")
                    //                        .fontWeight(.semibold)
                        .bold()
                        .font(.title2)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                    Spacer()
                }
                
                VStack(spacing: 28){
                    ForEach(viewModel.trashSelectionCards){
                        roomSelectionCard in
                        
                        RoomSelectionCardView(roomName: roomSelectionCard.trashName, roomEmoji: roomSelectionCard.trashEmoji)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            .neroGray
        )
    }
    
}

#Preview {
    TrashSelectionView()
}
