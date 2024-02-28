//
//  RoomSelectionCardView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 21.02.2024.
//

import SwiftUI

struct RoomSelectionCardView: View {
    
    var roomName: String
    var roomEmoji: String
    
    @State var isSelected = false
    
    var body: some View {
        
        HStack{
            Text(roomEmoji)
                .font(.title2)
                .padding(.all, 10)
                .background(
                    ZStack{
                        Color(.white)
                        
                        Color(getPastelColor(roomEmoji)).opacity(0.3)
                    }
                )
                .clipShape(Circle())
            
            VStack (alignment: .leading){
                Text(roomName)
                    .font(.headline)
                    .bold()
            }
            .frame(minWidth: 0,maxWidth: .infinity, maxHeight:.infinity, alignment:.leading)
            
            Button(action: {withAnimation{isSelected.toggle()}}, label: {
                Image(systemName: isSelected ? "plus.circle.fill" : "plus.circle")
                    .font(.title2)
                    .foregroundColor(.white)
            })
            
        }
        .frame(width: .infinity, height: 50)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .padding(-10)
                .padding(.horizontal, 20)
        )
        
    }
}

#Preview {
    RoomSelectionView()
}
