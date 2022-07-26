//
//  Colors + extension.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 19.06.2022.
//

import Foundation
import UIKit

extension UIColor {
    enum TextColor {
        static let darkBlue = UIColor(named: "DarkBlueText")
        static let lightGrey = UIColor(named: "LightGreyText")
        static let redError = UIColor(named: "RedErrorText")
    }
    
    enum TextFieldColor {
        static let general = UIColor(named: "GeneralTextField")
        static let error = UIColor(named: "ErrorTextField")
    }
    
    enum Background {
        static let lightGrey = UIColor(named: "LightGreyBackground")
        static let lightRed = UIColor(named: "LightRedBackgroud")
    }
    
    enum GradientBlue {
        static let left = UIColor(named: "Left")?.cgColor
        static let right = UIColor(named: "Right")?.cgColor
    }
    
}
extension CGColor {
    enum BorderColor {
        static let lightGrey = UIColor(named: "LightGreyBorderColor")?.cgColor
        static let lightBlue = UIColor(named: "LightBlueBorderColor")?.cgColor
    }
    
    enum GradientBlue {
        static let left = UIColor(named: "Left")?.cgColor
        static let right = UIColor(named: "Right")?.cgColor
    }
}

extension CAGradientLayer {
    enum GradientBlue {
        static let left = UIColor(named: "Left")?.cgColor
        static let right = UIColor(named: "Right")?.cgColor
    }
}
