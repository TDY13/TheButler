//
//  PhoneService.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 31.05.2022.
//

import Foundation
import UIKit

class PhoneService {
    static var phones: [String: (String, String, UIImage)] = {
        var codes = [String: (String, String, UIImage)] ()
        codes["USA"] = ("United States", "+1", UIImage(named: "USA") ?? UIImage())
        codes["GB"] = ("Great Britain", "+123", UIImage(named: "GB") ?? UIImage())
        codes["AUS"] = ("Australia", "+12", UIImage(named: "AUS") ?? UIImage())
       return codes
    }()
}
