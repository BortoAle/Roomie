//
//  OnboardingCardView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 19.02.2024.
//

import SwiftUI

struct OnboardingCardView: View {
    var headerText: String
    var descriptionText: String
    var iconName: String
    
    let iconSize: CGFloat = 40
    
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: "circle")
                .foregroundColor(.clear)
                .font(.system(size: iconSize))
                .fontWeight(.medium)
                .overlay(
                    Image(systemName: iconName)
                        .foregroundColor(.accentColor)
                        .font(.system(size: iconSize))
                        .fontWeight(.medium)
                )
            
            VStack(alignment: .leading){
                Text(headerText)
                    .fontWeight(.bold)
                
                Text(descriptionText)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    OnboardingCardView(headerText: "Hello World", descriptionText: "Sed cupidatat enim occaecat fugiat fugiat ea sint mollit proident ad laborum.", iconName: "xmark")
}
