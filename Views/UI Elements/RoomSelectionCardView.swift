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
    var dominantColor: Color
    
    @State var isSelected = false
    
    var body: some View {
        
        HStack{
            ZStack{
                Circle()
                    .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 50)
                    .foregroundColor(.white)
                Circle()
                    .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 50)
                    .foregroundColor(dominantColor)
                    .opacity(0.2)
                Text(roomEmoji)
                
            }.clipped()
            
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
