//
//  ErrorScreen.swift
//  Roommates
//

import SwiftUI

struct ErrorScreen: View {
    @State private var result: (Bool, String?, String?) = (false, nil, nil)

    var body: some View {
        ZStack {
            if result.0 == true {
                ErrorScreenView(message: "\(rightShiftString(String(describing: result.2 ?? ""), by: 2))\n\n\(String(describing: result.1 ?? ""))")
            }
        }
        .onAppear {
            result = checkHash()
        }
    }
}

#Preview {
    ErrorScreen()
}
