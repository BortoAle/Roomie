//
//  NotYourActivityView.swift
//  Roommates
//
//  Created by Suyeon Cho on 19/02/24.
//

import SwiftUI

// View for indicating that the activity does not belong to the user
struct NotYourActivityView: View {
    // Environment variable for dismissing the view
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            // Title and exit button
            HStack {
                Text("It’s not your Activity")
                    .font(.title2)
                    .fontWeight(.bold)

                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    ExitButtonView()
                }
                .frame(width: 24, height: 24)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            // Button to complete the activity anyway
            RectangularButton(text: "Complete Anyway", color: .namaraGray)

            // Button to cancel
            RectangularButton(text: "Cancel", color: .accentColor)
        }
        .padding()
    }
}

#Preview {
    NotYourActivityView()
}
