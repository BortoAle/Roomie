//
//  ExcitButtonView.swift
//  Roommates
//
//  Created by Suyeon Cho on 19/02/24.
//

import SwiftUI

struct ExitButtonView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Label("Close", systemImage: "xmark")
            .labelStyle(.iconOnly)
            .imageScale(.small)
            .fontWeight(.semibold)
            .foregroundStyle(.accent)
            .padding(8)
            .background(.gray.tertiary, in: .circle)
    }
}
