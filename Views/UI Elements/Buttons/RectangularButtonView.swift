//
//  RectangularButton.swift
//  Roommates
//
//  Created by Mariia Chemerys on 19.02.2024.
//


import SwiftUI

struct RectangularButton: View {
    
    var text: String
    var color: Color
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            action?()
        })
        {
            Text(text)
                .font(.title3)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(color)
                )
        }
        
    }
}


#Preview {
    RectangularButton(text: "Test Button", color: .accentColor)
}
