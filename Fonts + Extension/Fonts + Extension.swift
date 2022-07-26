//
//  Fonts + Extension.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 02.06.2022.
//

import UIKit

enum SkModernistFontType: String {
    case bold = "Sk-Modernist-Bold"
    case mono = "Sk-Modernist-Mono"
    case regular = "Sk-Modernist-Regular"
}

extension UIFont {
    static func skModernist(type: SkModernistFontType, ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: type.rawValue, size: ofSize) {
            return font
        } else {
            return .systemFont(ofSize: ofSize)
        }
    }
}
