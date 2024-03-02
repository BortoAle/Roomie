//
//  JoinGroupView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 19.02.2024.
//

import SwiftUI

struct JoinGroupView: View {
    @State private var isLoaded = false
    
    var body: some View {
            VStack {
                Text("Ask the creator of your group to send you an invitation link")
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                
                Spacer()
                
                Image(systemName: "link")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 115))
                    .symbolEffect(.bounce, value: isLoaded)
                    .onAppear {
                        isLoaded = true
                    }
                
                Spacer()
                
                RectangularButton(
                    text: "Create group instead",
                    color: .accentColor
                )
                .padding(.horizontal)
                .overlay(
                    NavigationLink(destination: RoomSelectionView()) {
                        Color.clear
                    }
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                .neroGray
            )
        }
}

#Preview {
    JoinGroupView()
}
