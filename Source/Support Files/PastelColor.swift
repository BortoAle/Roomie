//
//  PastelColor.swift
//  Roommates
//
//  Created by Matt Novoselov on 22/02/24.
//

import Foundation
import UIKit
import ColorKit

// Function to get a pastel color based on an emoji string
func getPastelColor(_ emojiString: String) -> UIColor {
    // Attempt to create an image from the emoji string
    if let emojiImage = imageFromEmojiString(emojiString, font: UIFont.systemFont(ofSize: 50), size: CGSize(width: 100, height: 100)) {
        // Get dominant colors from the image
        if let dominantColors = getDominantColors(from: emojiImage) {
            // Return the background color from the palette
            if let palette = ColorPalette(orderedColors: dominantColors, ignoreContrastRatio: true) {
                return palette.background
            }
        }
    }

    // If any step fails, return basic white color
    return .white
}

func imageFromEmojiString(_ emojiString: String, font: UIFont, size: CGSize) -> UIImage? {
    // Create a label to render the emoji string
    let label = UILabel(frame: CGRect(origin: .zero, size: size))
    label.font = font
    label.text = emojiString

    // Render the label to an image
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    defer { UIGraphicsEndImageContext() }
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    label.layer.render(in: context)
    let image = UIGraphicsGetImageFromCurrentImageContext()

    return image
}

// Function to extract dominant colors from the image
func getDominantColors(from image: UIImage) -> [UIColor]? {
    // Try With PNG Data
    if
        let pngData = image.pngData(),
        let pngImage = UIImage(data: pngData),
        let colors = try? pngImage.dominantColors(with: .best, algorithm: .iterative),
        !colors.isEmpty {
        return colors
    }
    // Try With JPEG Data
    if
        let jpegData = image.jpegData(compressionQuality: 1),
        let jpegImage = UIImage(data: jpegData),
        let colors = try? jpegImage.dominantColors(with: .best, algorithm: .iterative),
        !colors.isEmpty {
        return colors
    }
    // Try With Original Image
    if let colors = try? image.dominantColors(with: .best, algorithm: .iterative), !colors.isEmpty {
        return colors
    }

    // If previous operation were unsuccessful, return error
    return nil
}
