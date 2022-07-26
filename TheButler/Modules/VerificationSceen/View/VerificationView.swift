//
//  VerificationView.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 30.05.2022.
//

import Foundation
import UIKit

class VerificationView: UIView {
    var isShow: Bool = false

    var logoImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: .Image.USA)
        return view
    }()
    
    var greetingsLabel: UILabel = {
        var label = UILabel()
        label.text = .Text.hello
        label.font = .skModernist(type: .bold, ofSize: 35)
        return label
    }()
    
    var verifyLabel: UILabel = {
        var label = UILabel()
        label.text = .Text.letsVerifyYourAccount
        label.numberOfLines = 2
        label.font = .skModernist(type: .regular, ofSize: 28)
        return label
    }()
    
    var shieldImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: .Image.shield)
        return view
    }()
    
    var chooseLabel: UILabel = {
        var label = UILabel()
        label.text = .Text.chooseWhatToStartWith
        label.font = .skModernist(type: .bold, ofSize: 16)
        return label
    }()
    
    var emailButton: Checkbox = {
        var button = Checkbox()
        button.checkboxTitle = .Text.email
        button.isSelected = true
        return button
    }()
    
    var phoneNumberButton: Checkbox = {
        var button = Checkbox()
        button.checkboxTitle = .Text.phoneNumber
        return button
    }()
    
    var dividingLineView: UIView = {
        var view = UIView()
        view.backgroundColor = .Background.lightGrey
        return view
    }()
    
    var enterChosenAuthenticatorLabel: UILabel = {
        var label = UILabel()
        label.text = .Text.enterYourEmailAddress
        label.font = UIFont(name: SkModernistFontType.bold.rawValue, size: 16)
        return label
    }()
    
    var emailTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .TextFieldColor.general
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.keyboardType = .emailAddress
        textField.placeholder = .Text.exampleEmail
        textField.font = .skModernist(type: .regular, ofSize: 15)
        textField.layer.masksToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.returnKeyType = .done
        return textField
    }()
    
    var phoneTextField: TextFieldWithPadding = {
        var textField = TextFieldWithPadding()
        textField.backgroundColor = .TextFieldColor.general
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.keyboardType = .phonePad
        textField.text = .Text.plusOne
        textField.font = .skModernist(type: .regular, ofSize: 15)
        textField.layer.masksToBounds = true
        textField.isHidden = true
        textField.textPadding = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 15)
        return textField
    }()
    
    var verificationDescriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.text = .Text.verificationCodeWillBeSentToYourEmail
        label.font = .skModernist(type: .regular, ofSize: 14)
        return label
    }()
    
    var continueButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: .Image.RectangleWithShadow), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 15
        return button
    }()
    
    var continueLabel: UILabel = {
        var label = UILabel()
        label.text = .Text.continueText
        label.font = .skModernist(type: .bold, ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    var pointerImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: .Image.pointer)
        return image
    }()
    
    var phonePickerView: PhoneNumberView = {
        var view = PhoneNumberView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var showPickerButton: UIButton = {
        var button = UIButton()
        button.isHidden = true
        return button
    }()
    
    var flagPickerView: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: .Image.USA)
        image.layer.cornerRadius = 11
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var flagPointerView: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: .Image.flagPointer)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(logoImage)
        addSubview(greetingsLabel)
        addSubview(verifyLabel)
        addSubview(shieldImage)
        
        addSubview(chooseLabel)
        addSubview(emailButton)
        addSubview(phoneNumberButton)
        addSubview(dividingLineView)
        
        addSubview(enterChosenAuthenticatorLabel)
        addSubview(emailTextField)
        addSubview(phoneTextField)
        addSubview(verificationDescriptionLabel)
        phoneTextField.addSubview(showPickerButton)
        
        showPickerButton.addSubview(flagPickerView)
        showPickerButton.addSubview(flagPointerView)
        
        addSubview(continueButton)
        continueButton.addSubview(continueLabel)
        continueButton.addSubview(pointerImage)
        
        addSubview(phonePickerView)
        
        logoImage.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(80)
            $0.left.equalTo(snp.left).offset(27)
        }
        
        greetingsLabel.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(42)
            $0.left.equalTo(snp.left).offset(24)
        }
        
        shieldImage.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalTo(logoImage.snp.bottom).offset(27)
        }
        
        verifyLabel.snp.makeConstraints {
            $0.left.equalTo(27)
            $0.top.equalTo(greetingsLabel.snp.bottom).offset(10)
        }
        
        chooseLabel.snp.makeConstraints {
            $0.top.equalTo(shieldImage.snp.bottom).offset(52)
            $0.left.equalTo(snp.left).offset(27)
        }
        
        emailButton.snp.makeConstraints {
            $0.left.equalTo(snp.left).offset(27)
            $0.top.equalTo(chooseLabel.snp.bottom).offset(29)
            $0.height.equalTo(20)
        }
        
        phoneNumberButton.snp.makeConstraints {
            $0.top.equalTo(emailButton.snp.top)
            $0.height.equalTo(20)
            $0.left.equalTo(emailButton.snp.right).offset(44)
        }
        
        dividingLineView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(emailButton.snp.bottom).offset(41)
            $0.height.equalTo(1)
        }
        
        enterChosenAuthenticatorLabel.snp.makeConstraints {
            $0.top.equalTo(dividingLineView.snp.bottom).offset(39)
            $0.left.equalTo(logoImage.snp.left)
        }
        
        emailTextField.snp.makeConstraints {
            $0.left.equalTo(logoImage.snp.left)
            $0.right.equalTo(snp.right).offset(-27)
            $0.top.equalTo(enterChosenAuthenticatorLabel.snp.bottom).offset(23)
            $0.height.equalTo(57)
        }
        
        phoneTextField.snp.makeConstraints {
            $0.left.equalTo(logoImage.snp.left)
            $0.right.equalTo(snp.right).offset(-27)
            $0.top.equalTo(enterChosenAuthenticatorLabel.snp.bottom).offset(23)
            $0.height.equalTo(57)
        }
        
        verificationDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(8)
            $0.left.equalTo(snp.left).offset(46)
            $0.right.equalTo(snp.right).offset(-22)
        }
        
        continueButton.snp.makeConstraints {
            $0.left.equalTo(snp.left)
            $0.right.equalTo(snp.right)
            $0.top.equalTo(emailTextField.snp.bottom).offset(90)
            $0.height.equalTo(125)
        }
        
        continueLabel.snp.makeConstraints {
            $0.left.equalTo(snp.left).offset(48)
            $0.top.equalTo(continueButton.snp.top).offset(33)
        }
        
        pointerImage.snp.makeConstraints {
            $0.top.equalTo(continueButton.snp.top).offset(31)
            $0.right.equalTo(snp.right).offset(-51.5)
        }
        
        phonePickerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(390)
            make.top.equalTo(self.snp.bottom)
        }
        
        showPickerButton.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.width.equalTo(50)
            $0.left.equalTo(emailTextField.snp.left).offset(22)
            $0.top.equalTo(emailTextField.snp.top).offset(18)
        }
        
        flagPickerView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.size.equalTo(20)
            $0.centerY.equalTo(showPickerButton.snp.centerY)
        }
        
        flagPointerView.snp.makeConstraints {
            $0.left.equalTo(flagPickerView.snp.right).offset(10)
            $0.centerYWithinMargins.equalTo(flagPickerView.snp.centerYWithinMargins)
        }
    }
    
    func showPickerView() {
        UIView.animate(withDuration: 0.3) {
            self.phonePickerView.snp.updateConstraints { make in
                make.top.equalTo(self.snp.bottom).offset(-390)
            }
            self.layoutIfNeeded()
        }
    }
    
    func hidePickerView() {
        UIView.animate(withDuration: 0.3) {
            self.phonePickerView.snp.updateConstraints { make in
                make.top.equalTo(self.snp.bottom).offset(0)
            }
            self.layoutIfNeeded()
        }
    }
    
    func handleUI(_ isChanged: Bool) {
        emailTextField.isHidden = !isChanged
        phoneTextField.isHidden = isChanged
        verificationDescriptionLabel.text = isChanged ? .Text.verificationCodeWillBeSentToYourEmail : .Text.verificationCodeWillBeSentToYourNumber
        enterChosenAuthenticatorLabel.text = isChanged ? .Text.enterYourEmailAddress : .Text.enterYourPhoneNumber
        emailTextField.text = isChanged ? "" : .Text.plusOne
        showPickerButton.isHidden = isChanged
    }
}
