//
//  AddResidentViewController.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 14.06.2022.
//

import UIKit
import ContactsUI

class AddResidentsViewController: UIViewController {
    var isKeyboardAppear = false
    
    var mainView = AddResidentsView()
    weak var delegate: ResidentSavable?
    var closeTap: UITapGestureRecognizer?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    func initViewController() {
        self.closeTap = UITapGestureRecognizer(target: self, action: #selector(didTapCloseButton))
        if let closeTap = self.closeTap {
            mainView.transparentView.addGestureRecognizer(closeTap)
        }
        addDoneButtonOnKeyboard()
        
        mainView.nameTextField.delegate = self
        mainView.mobileNumberTextField.delegate = self
        
        mainView.closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        mainView.managerButton.addTarget(self, action: #selector(didTapOnChangeableButtons(_:)), for: .touchUpInside)
        mainView.hiddenButton.addTarget(self, action: #selector(didTapOnChangeableButtons(_:)), for: .touchUpInside)
        mainView.heartButton.addTarget(self, action: #selector(didTapOnChangeableButtons(_:)), for: .touchUpInside)
        mainView.addResidentButton.addTarget(self, action: #selector(didTapResidentButton), for: .touchUpInside)
        mainView.contactListButton.addTarget(self, action: #selector(didTapContactListButton), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func addDoneButtonOnKeyboard() {
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()
        
        mainView.mobileNumberTextField.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            mainView.mobileNumberTextField.resignFirstResponder()
            
        }
    
    func reloadView() {
        mainView.mobileNumberTextField.reloadInputViews()
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapResidentButton() {
        if mainView.nameTextField.text == "" {
            let alert = UIAlertController(title: "Enter name field", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            if mainView.mobileNumberTextField.text == "" {
                let alert = UIAlertController(title: "Enter phone number field", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                didReceiveData()
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func didReceiveData() {
        guard let name = mainView.nameTextField.text,
              let mobileNumber = mainView.mobileNumberTextField.text
        else {
            return
        }
        let model = ResidentModel(name: name,
                                   mobileNumber: mobileNumber,
                                   manager: mainView.managerButton.isSelected,
                                   hidden: mainView.hiddenButton.isSelected,
                                   heart: mainView.heartButton.isSelected)
        delegate?.save(model)
    }
    
    @objc private func didTapOnChangeableButtons(_ sender: SquereCheckbox) {
        switch sender {
        case mainView.managerButton :
            if mainView.managerButton.isSelected == true {
                mainView.managerButton.isSelected = false
            } else {
                mainView.managerButton.isSelected = true
            }
        case mainView.hiddenButton :
            if mainView.hiddenButton.isSelected == true {
                mainView.hiddenButton.isSelected = false
            } else {
                mainView.hiddenButton.isSelected = true
            }
        case mainView.heartButton :
            if mainView.heartButton.isSelected == true {
                mainView.heartButton.isSelected = false
            } else {
                mainView.heartButton.isSelected = true
            }
        default:
            return
        }
    }
    
    @objc private func didTapContactListButton() {
        presentContactPickerVC()
    }
    
    func presentContactPickerVC() {
        let viewController = ContactPickerViewController()
        viewController.delegate = self
        present(viewController, animated: true)
    }
}

//MARK: - Keyboard observer
extension AddResidentsViewController {
    @objc private func keyboardWillShow(notification: NSNotification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        
        if !isKeyboardAppear {
            
            UIView.animate(withDuration: duration ?? 0) {
                self.mainView.containerView.snp.updateConstraints { make in
                    make.centerY.equalTo(self.mainView.transparentView.snp.centerY).offset(-150)
                }
                self.mainView.layoutIfNeeded()
            }
            isKeyboardAppear = true
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        
        if isKeyboardAppear {
            
            UIView.animate(withDuration: duration ?? 0) {
                self.mainView.containerView.snp.updateConstraints { make in
                    make.centerY.equalTo(self.mainView.transparentView.snp.centerY)
                }
                self.mainView.layoutIfNeeded()
            }
            isKeyboardAppear = false
        }
    }
}
//MARK: - Contact picker delegate
extension AddResidentsViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let userPhoneNumbers:[CNLabeledValue<CNPhoneNumber>] = contact.phoneNumbers
        let firstPhoneNumber:CNPhoneNumber = userPhoneNumbers[0].value
        
        mainView.mobileNumberTextField.text = firstPhoneNumber.stringValue
    }
}
//MARK: - TextField delegate
extension AddResidentsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = mainView.nameTextField.text else { return true }
        if text.isEmpty{
            let alert = UIAlertController(title: "Enter name field", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            mainView.mobileNumberTextField.becomeFirstResponder()
        }
        return true
    }
}
