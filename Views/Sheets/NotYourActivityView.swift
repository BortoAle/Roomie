//
//  NotYourActivityView.swift
//  Roommates
//
//  Created by Suyeon Cho on 19/02/24.
//

import SwiftUI

struct NotYourActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Text("It’s not your Activity")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    ExitButtonView()
                    
                }
                .frame(width: 24, height: 24)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            RectangularButton(text: "Complete Anyway", color: .namaraGray)
            
            RectangularButton(text: "Cancel", color: .accentColor)
            
        }
        .padding()
        
    }
}


#Preview {
    NotYourActivityView()
}
