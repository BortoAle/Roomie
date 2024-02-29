//
//  RandomHashView.swift
//  Roommates
//
//  Created by Matt Novoselov on 16/02/24.
//

import SwiftUI

struct RandomHashView: View {
    @State var textField: String = ""
    @State var hashedValue: Int = 0
    let roommatesList: [String] = ["Mariia", "Matt", "Alessandro", "Simi", "Su"]
    
    var body: some View {
        VStack{
            TextField("", text: $textField)
                .onChange(of: textField){
                    let hash = textField.hash
                    let range = 0..<roommatesList.count
                    let mappedNumber = hashToNumber(hash: hash, range: range)
                    hashedValue = mappedNumber
                }
            
            Text(roommatesList[hashedValue])
        }
    }
}

func hashToNumber(hash: Int, range: Range<Int>) -> Int {
    // Take absolute value of hash to handle negative hashes
    let absHash = abs(hash)
    
    // Map hash value to the range
    let mappedValue = absHash % (range.upperBound - range.lowerBound) + range.lowerBound
    
    return mappedValue
}

#Preview {
    RandomHashView()
}
