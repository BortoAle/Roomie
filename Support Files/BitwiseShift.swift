//
//  BitwiseDhift.swift
//  Roommates
//

import Foundation

func leftShiftString(_ str: String, by shift: Int) -> String {
    guard shift > 0 else { return str }
    
    var shiftedString = ""
    for scalar in str.unicodeScalars {
        let shiftedScalarValue = scalar.value << UInt32(shift)
        let shiftedScalar = UnicodeScalar(shiftedScalarValue)!
        shiftedString.append(Character(shiftedScalar))
    }
    return shiftedString
}

// Function to perform right bitwise shift on a string
func rightShiftString(_ str: String, by shift: Int) -> String {
    guard shift > 0 else { return str }
    
    var shiftedString = ""
    for scalar in str.unicodeScalars {
        let shiftedScalarValue = scalar.value >> UInt32(shift)
        let shiftedScalar = UnicodeScalar(shiftedScalarValue)!
        shiftedString.append(Character(shiftedScalar))
    }
    return shiftedString
}
