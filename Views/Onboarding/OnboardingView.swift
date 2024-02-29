//
//  OnboardingView.swift
//  Roommates
//
//  Created by Mariia Chemerys on 19.02.2024.
//

import SwiftUI

struct OnboardingView: View {
    @State var animationPhase: Int = 0
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Welcome to Roomie")
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 50)
                    .opacity(animationPhase >= 1 ? 1 : 0)
                
                VStack(spacing: 25){
                    OnboardingCardView(headerText: "Add your roommates", descriptionText: "Create a shared space for coordination and collaboration.", iconName: "person.2")
                        .opacity(animationPhase >= 2 ? 1 : 0)
                    
                    OnboardingCardView(headerText: "Schedule cleaning", descriptionText: "Set up and organize a cleaning schedule for shared living spaces.", iconName: "bubbles.and.sparkles")
                        .opacity(animationPhase >= 3 ? 1 : 0)
                    
                    OnboardingCardView(headerText: "Adjust trash schedule", descriptionText: "Customize and adjust reminders for timely trash disposal.", iconName: "trash")
                        .opacity(animationPhase >= 4 ? 1 : 0)
                }
                .padding(.horizontal, 25)
                
                Spacer()
                
                RectangularButton(
                    text: "Create new group",
                    color: .accentColor)
                .padding(.horizontal)
                .overlay(
                    NavigationLink(destination: RoomSelectionView()) {
                        Color.clear
                    }
                )
                
                RectangularButton(
                    text: "Join group",
                    color: .namaraGray)
                .padding(.horizontal)
                .overlay(
                    NavigationLink(destination: JoinGroupView()) {
                        Color.clear
                    }
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                .neroGray
            )
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                    if animationPhase < 4 {
                        withAnimation(){
                            animationPhase += 1
                        }
                    } else {
                        timer.invalidate()
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    OnboardingView()
}
