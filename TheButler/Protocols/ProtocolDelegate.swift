//
//  ProtocolDelegare.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 17.06.2022.
//

import Foundation
import ContactsUI

protocol ResidentSavable: AnyObject {
    func save(_ data: ResidentModel)
}
