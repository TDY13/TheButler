//
//  Constant.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 25.06.2022.
//

import Foundation

struct Constants {
    static let baseURL = ""
}

enum APIRoutes {
    case initURL
    case startURL
    case verifyURL
    case loginURL
    case logoutURL
    
    var urlString: String {
        switch self {
        
        case .initURL:
            return ""
        case .startURL:
            return ""
        case .verifyURL:
            return ""
        case .loginURL:
            return ""
        case .logoutURL:
            return ""
        }
    }
}

