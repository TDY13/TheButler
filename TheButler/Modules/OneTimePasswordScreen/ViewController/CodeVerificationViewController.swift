//
//  CodeVerificationViewController.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 03.06.2022.
//

import UIKit

class CodeVerificationViewController: UIViewController {
    var isKeyboardAppear = false
    var verifyMessage: String?
    private let mainView = CodeVerificationView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        initViewController()
    }
    
    private func initViewController() {
        mainView.otpView.delegate = self
        mainView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        mainView.verifyButton.addTarget(self, action: #selector(didTapVerifyButton), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func verificationRequestProcessing() {
        self.mainView.spinner.startAnimating()
        guard let verifyModel = getVerifyModel() else { return }
        AuthService.shared.verifyRequest(model: verifyModel) { response in
            print("3️⃣✅\(response.data)")
            print("\(response.message)✅")
            self.loginRequestProcessing()
        } fail: { error in
            self.mainView.spinner.stopAnimating()
            print("3️⃣\(error)")
            self.errorProcessing()
        }
    }
    
    func loginRequestProcessing() {
        guard let loginModel = getLoginModel() else { return }
        AuthService.shared.loginRequest(model: loginModel) { response in
            print("4️⃣\(String(describing: response.message))4️⃣")
            self.verifyMessage = response.message
            self.loginDataProcessing()
        } fail: { error in
            self.mainView.spinner.stopAnimating()
            self.errorProcessing()
            print("4️⃣⛔️\(error)⛔️")
        }
    }
    
    func getVerifyModel() -> VerifyRequestModel? {
        let email = ""
        guard let code = mainView.otpView.code else { return nil }
        return VerifyRequestModel(emailOrNumber: email, code: code, secondAuthToken: "asdas")
    }
    
    func getLoginModel() -> LoginRequestModel? {
        guard let deviceUUID = UIDevice.current.identifierForVendor?.uuidString else {
            return nil
        }
        return LoginRequestModel(deviceUUID: deviceUUID)
    }
}
//MARK: - Targets
extension CodeVerificationViewController {
    @objc private func didTapVerifyButton() {
        verificationRequestProcessing()
    }
    
    private func showHomeVC() {
        let viewController = HomeViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func loginDataProcessing() {
        self.mainView.spinner.stopAnimating()
        self.showHomeVC()
    }
    
    private func errorProcessing() {
        guard let code = mainView.otpView.code else { return }
        
        if code.count < 4 {
            let alert = UIAlertController(title: "❌", message: "Enter all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else if verifyMessage != "OK" {
            let alert = UIAlertController(title: "Wrong password", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: { action in
                self.mainView.otpView.isError.toggle()
                self.mainView.errorAlertLabel.isHidden = false
                self.mainView.otpView.textField.becomeFirstResponder()
            }))
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Network technical issues", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Reload", style: .cancel, handler: { action in
                self.didTapBackButton()
            }))
            present(alert, animated: true, completion: nil)
        }
    }

    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        
        if !isKeyboardAppear {
            UIView.animate(withDuration: duration ?? 0) {
                self.mainView.containerView.snp.updateConstraints { make in
                    make.top.equalTo(self.mainView.backButton.snp.bottom).offset(97)
                }
                self.mainView.shieldImage.snp.updateConstraints {
                    $0.right.equalTo(self.mainView.snp.right).offset(-6)
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
                    make.top.equalTo(self.mainView.backButton.snp.bottom).offset(227)
                }
                self.mainView.shieldImage.snp.updateConstraints {
                    $0.right.equalTo(self.mainView.snp.right).offset(-101)
                }
                self.mainView.layoutIfNeeded()
            }
            isKeyboardAppear = false
        }
    }
}

//MARK: - OTPView delegate
extension CodeVerificationViewController: OTPViewDelegate {
    
    func didFullCodeCompletion(_ otpView: OTPView) {
        print("code -> \(String(describing: otpView.code))")
    }
}
