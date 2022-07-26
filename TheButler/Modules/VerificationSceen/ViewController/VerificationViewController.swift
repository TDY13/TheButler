//
//  ViewController.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 30.05.2022.
//

import UIKit

class VerificationViewController: UIViewController {
    var isKeyboardAppear = false
    var startMessage: String?
    private let mainView = VerificationView()
    var closeTap: UITapGestureRecognizer?
    
    lazy var phonePickerModels: [PhonePickerModel] = {
        var models: [PhonePickerModel] = []
        
        for (code, value) in PhoneService.phones
        {
            models.append(.init(code: code, countryCode: value.1, title: value.0, icon: value.2))
        }
        return models
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        addDoneButtonOnKeyboard()
        
        mainView.emailTextField.delegate = self
        mainView.phoneTextField.delegate = self
        
        mainView.phonePickerView.phoneNumberPicker.delegate = self
        mainView.phonePickerView.phoneNumberPicker.dataSource = self
        
        mainView.phoneNumberButton.addTarget(self, action: #selector(didCheckboxTapped(_:)), for: .touchUpInside)
        mainView.emailButton.addTarget(self, action: #selector(didCheckboxTapped(_:)), for: .touchUpInside)
        mainView.showPickerButton.addTarget(self, action: #selector(didshowPickerButtonTapped(_:)), for: .touchUpInside)
        mainView.phonePickerView.selectButton.addTarget(self, action: #selector(didshowPickerButtonTapped(_:)), for: .touchUpInside)
        mainView.phonePickerView.titleButton.addTarget(self, action: #selector(didshowPickerButtonTapped(_:)), for: .touchDragInside)
        mainView.continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func initDevice() {
        guard let model = getInitModel() else {
            return
        }
        AuthService.shared.initRequest(model: model) { result in
            print("1️⃣✅\(result.message)✅")
            self.startRequestProcessing()
        } fail: { error in
            print("1️⃣\(error)")
            let alert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getInitModel() -> InitRequestModel? {
        guard let deviceUUID = UIDevice.current.identifierForVendor?.uuidString else {
            return nil
        }
        guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return nil
        }
        return InitRequestModel(deviceUUID: deviceUUID,
                                manufacturer: .Text.apple,
                                model: UIDevice.current.model,
                                platform: UIDevice.current.systemName,
                                osVersion: UIDevice.current.systemVersion,
                                appVersion: appVersion)
    }
    
    private func startRequestProcessing() {
        guard let startModel = startModelFilling() else { return }
        AuthService.shared.startRequest(model: startModel) { response in
            self.startMessage = response.message
            print("2️⃣✅\(response.message)✅")
            self.didShowCodeVerificationVC()
        } fail: { error in
            print("2️⃣❌\(error)❌")
            self.errorProcessing()
        }
    }
    
    func didShowCodeVerificationVC() {
        if startMessage == "SMS successfully sent" {
            let viewController = CodeVerificationViewController()
            viewController.navigationItem.hidesBackButton = true
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            userDoesNotExistNotice()
        }
        
    }
    
    private func userDoesNotExistNotice() {
        let alert = UIAlertController(title: "User does not exist", message: "Try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func errorProcessing() {
        let alert = UIAlertController(title: "Network error", message: "Try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func startModelFilling() -> StartRequestModel? {
        let number = mainView.phoneTextField.text
        let email = mainView.emailTextField.text
        if number == nil {
            return StartRequestModel(emailOrNumber: (String(describing: email)))
        } else {
            return StartRequestModel(emailOrNumber: (String(describing: number)))
        }
    }
    
    private func addDoneButtonOnKeyboard() {
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

        mainView.phoneTextField.inputAccessoryView = doneToolbar
        }

        @objc private func doneButtonAction(){
            mainView.phoneTextField.resignFirstResponder()
        }
}

//MARK: helpers and handlers
extension VerificationViewController {
    
}

//MARK: targets
extension VerificationViewController {
    @objc private func didCheckboxTapped(_ sender: Checkbox) {
        switch sender {
        case mainView.emailButton :
            sender.isSelected = true
            mainView.phoneNumberButton.isSelected = false
            mainView.handleUI(true)
            mainView.phoneTextField.resignFirstResponder()
        case mainView.phoneNumberButton:
            sender.isSelected = true
            mainView.emailButton.isSelected = false
            mainView.handleUI(false)
            mainView.emailTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    @objc private func didshowPickerButtonTapped(_ sender: UIButton) {
        mainView.isShow ? mainView.showPickerView() : mainView.hidePickerView()
        mainView.isShow.toggle()
    }
    
    @objc private func didTapContinueButton() {
        validatingTheLoginField()
    }
    
    private func validatingTheLoginField() {
        guard let email = mainView.emailTextField.text else { return }
        guard let number = mainView.phoneTextField.text else { return }
        
        if email.isEmpty || number.isEmpty{
            let alert = UIAlertController(title: "Enter email or number fields", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true)
        } else {
            initDevice()
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        if !isKeyboardAppear {
            UIView.animate(withDuration: duration ?? 0) {
                self.mainView.chooseLabel.snp.updateConstraints { make in
                    make.top.equalTo(self.mainView.shieldImage.snp.bottom).offset(0)
                }
                self.mainView.dividingLineView.snp.updateConstraints {
                    $0.top.equalTo(self.mainView.emailButton.snp.bottom).offset(10)
                }
                self.mainView.enterChosenAuthenticatorLabel.snp.updateConstraints {
                    $0.top.equalTo(self.mainView.dividingLineView.snp.bottom).offset(5)
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
                self.mainView.chooseLabel.snp.updateConstraints { make in
                    make.top.equalTo(self.mainView.shieldImage.snp.bottom).offset(52)
                }
                self.mainView.dividingLineView.snp.updateConstraints {
                    $0.top.equalTo(self.mainView.emailButton.snp.bottom).offset(41)
                }
                self.mainView.enterChosenAuthenticatorLabel.snp.updateConstraints {
                    $0.top.equalTo(self.mainView.dividingLineView.snp.bottom).offset(39)
                }
                self.mainView.layoutIfNeeded()
            }
            isKeyboardAppear = false
        }
    }
}
//MARK: - PickerView Delegate
extension VerificationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return phonePickerModels.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        60
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let model = phonePickerModels[row]
        return PickerView.create(icon: model.icon, title: model.title, code: model.countryCode)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.subviews[1].backgroundColor = .clear
        let model = phonePickerModels[row]
        mainView.phoneTextField.text = "\(model.countryCode)"
        mainView.flagPickerView.image = model.icon
    }
}
//MARK: - TextField delegate
extension VerificationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainView.emailTextField.resignFirstResponder()
        return true
    }
}


