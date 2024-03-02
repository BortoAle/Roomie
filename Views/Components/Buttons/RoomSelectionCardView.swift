//
//  RoomSelectionCardView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 20.02.2024.
//

import SwiftUI

struct RoomSelectionCardView: View {
    var body: some View {
        
        HStack{
            ZStack{
                Circle()
                    .frame(minWidth: 0,maxWidth: 50,minHeight:0,maxHeight:50)
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
            }.clipped()
            
            VStack (alignment: .leading){
                Text("Kitchen")
                    .font(.headline)
                    .bold()
            }
            .frame(minWidth: 0,maxWidth: .infinity, maxHeight:.infinity, alignment:.leading)
            
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
