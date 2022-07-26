
//
//  SettingsModel.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 09.06.2022.
//

import Foundation
import UIKit
enum SettingsModel: CaseIterable {
    case displayName
    case doNotDisturb
    case ringtone
    case editResidents
    case widgetLock
    
    func getTitle() -> String {
        switch self {
        case .displayName :
            return "Your display name"
        case .doNotDisturb :
            return "Do not disturb"
        case .editResidents :
            return "Edit residents"
        case .widgetLock:
            return "Widget lock"
        case .ringtone:
            return "Ringtone"
        }
    }
    
    func getIcon() -> UIImage? {
        switch self {
        case .displayName:
            return UIImage(named: "Profile")
        case .doNotDisturb:
            return UIImage(named: "Notification")
        case .editResidents:
            return UIImage(named: "Password")
        case .widgetLock:
            return UIImage(named: "Profile")
        case .ringtone:
            return UIImage(named: "Volume")
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .displayName :
            return "This name will be dispayed everywhere"
        case .doNotDisturb :
            return "This name will be dispayed everywhere"
        case .editResidents :
            return "This name will be dispayed everywhere"
        case .widgetLock:
            return "This name will be dispayed everywhere"
        case .ringtone:
            return "This name will be dispayed everywhere"
        }
    }
}
