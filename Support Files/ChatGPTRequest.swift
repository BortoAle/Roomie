//
//  ChatGPTRequest.swift
//  Roommates
//
//  Created by Matt Novoselov on 15/02/24.
//

import Foundation

struct EmojiData: Codable {
    let emoji: String
}

func chatGPTRequest(inputPrompt: String, completion: @escaping (String?) -> Void) {
    guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
        print("Invalid URL")
        completion(nil)
        return
    }

    let openaiApiKey = "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"
    let requestData: [String: Any] = [
        "model": "gpt-3.5-turbo-0125",
        "messages": [
            ["role": "system", "content": loadFileContents(nameOfFileToLoad: "ChatGPT_Instruction_Text_To_Emoji")],
            ["role": "user", "content": inputPrompt]
        ]
    ]

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(openaiApiKey)", forHTTPHeaderField: "Authorization")

    guard let httpBody = try? JSONSerialization.data(withJSONObject: requestData) else {
        print("Error creating HTTP body")
        completion(nil)
        return
    }

    request.httpBody = httpBody

    URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            print("Error: \(error?.localizedDescription ?? "Unknown error")")
            completion(nil)
            return
        }

        do {
            if let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let completions = responseJSON["choices"] as? [[String: Any]],
               let firstCompletion = completions.first,
               let message = firstCompletion["message"] as? [String: Any],
               let content = message["content"] as? String {
                do {
                    // Decode JSON data into EmojiData struct
                    let emojiData = try JSONDecoder().decode(EmojiData.self, from: content.data(using: .utf8)!)

                    // Call completion handler with the decoded emoji
                    completion(emojiData.emoji.description)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            } else {
                print("Invalid response format")
                completion(nil)
            }
        } catch {
            print("Error decoding response: \(error)")
            completion(nil)
        }
    }.resume()
}
