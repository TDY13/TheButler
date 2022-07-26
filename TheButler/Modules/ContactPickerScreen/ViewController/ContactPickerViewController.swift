//
//  ContactPickerViewController.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 17.06.2022.
//

import Foundation
import UIKit
import ContactsUI

class ContactPickerViewController: CNContactPickerViewController {
    var phoneNumber = ""
}

//MARK: - Contact picker delegate
extension ContactPickerViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        phoneNumber = "\(contact.phoneNumbers)"
        
    }
}
