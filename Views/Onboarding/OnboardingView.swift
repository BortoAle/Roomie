//
//  OnboardingView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 19.02.2024.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack{
            Text("Welcome to the Roommates App")
                .fontWeight(.semibold)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding(.vertical, 50)
            
            VStack(spacing: 25){
            OnboardingCardView(headerText: "Add your roommates", descriptionText: "Create a shared space for coordination and collaboration.", iconName: "person.2")
                
                OnboardingCardView(headerText: "Schedule cleaning", descriptionText: "Set up and organize a cleaning schedule for shared living spaces.", iconName: "bubbles.and.sparkles")
                
                OnboardingCardView(headerText: "Adjust trash schedule", descriptionText: "Customize and adjust reminders for timely trash disposal.", iconName: "trash")
            }
            .padding(.horizontal, 25)
            
            Spacer()
            
            RectangularButton(
                text: "Create new group",
                color: .accentColor)
            .padding(.horizontal)
            
            RectangularButton(
                text: "Join group",
                color: .namaraGray)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            .neroGray
        )
        
    }
}

#Preview {
    OnboardingView()
}
