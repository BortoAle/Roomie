//
//  ErrorScreenView.swift
//  Roommates
//


import SwiftUI

struct ErrorScreenView: View {
    var message: String = "Unable to connect to CloudKit"

    var body: some View {
        VStack {
            Text("Ooups, there was an error:")
                .fontWeight(.semibold)
                .font(.largeTitle)
                .multilineTextAlignment(.center)

            Spacer()

            Text(message)
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(.accentColor)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            .neroGray
        )
    }
}

#Preview {
    ErrorScreenView()
}
