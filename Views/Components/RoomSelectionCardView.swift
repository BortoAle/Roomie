//
//  RoomSelectionCardView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import SwiftUI

struct RoomSelectionCardView: View {
	@Binding var amountOfCardsAdded: Int
	@State var isSelected = false
	
    var roomName: String
    var roomEmoji: String
    var addAction: (() -> Void)? = nil
    
    var body: some View {
        
        HStack(spacing: 15){
            Text(roomEmoji)
                .font(.title2)
                .padding(.all, 10)
                .background(
                    ZStack{
                        Color(.white)
                        
                        Color(getPastelColor(roomEmoji)).opacity(0.3)
                    }
                )
				.clipShape(.circle)
            
            VStack (alignment: .leading){
                Text(roomName)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            Button(action: {
                withAnimation{
                    isSelected.toggle()
                }
                
                if isSelected{
                    amountOfCardsAdded+=1
                    addAction?()
                }
            }, label: {
                Image(systemName: isSelected ? "plus.circle.fill" : "plus.circle")
                    .font(.title2)
            })
            
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.onboardingCardGray)
        )
    }
}

#Preview {
	RoomSelectionCardView(amountOfCardsAdded: .constant(0), roomName: "Test", roomEmoji: "❌")
}
