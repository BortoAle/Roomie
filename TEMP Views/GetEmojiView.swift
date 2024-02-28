//
//  LoadTxtFile.swift
//  Roommates
//
//  Created by Matt Novoselov on 15/02/24.
//

import SwiftUI

struct GetEmojiView: View {
    @State private var textInput: String = ""
    @State private var responseEmoji: String = ""
    
    var body: some View {
        HStack{
            Text(responseEmoji)
            
            TextField("Name of activity", text: $textInput)
                .onSubmit {
                    ChatGPTRequest(inputPrompt: textInput) { result in
                        responseEmoji = result ?? "❓"
                    }
                }
        }
        .padding()
    }
}

#Preview {
    GetEmojiView()
}
