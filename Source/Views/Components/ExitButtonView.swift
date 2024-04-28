//
//  ExcitButtonView.swift
//  Roommates
//
//  Created by Suyeon Cho on 19/02/24.
//

import SwiftUI

// Exit button is used to dismiss sheets
// Should be used on top trailing corner of the sheet
struct ExitButtonView: View {
    var body: some View {
        Image(systemName: "xmark")
            .imageScale(.small)
            .fontWeight(.semibold)
            .foregroundStyle(.accent)
            .padding(8)
            .background(.gray.tertiary, in: .circle)
            .accessibility(label: Text("Close"))
    }
}
