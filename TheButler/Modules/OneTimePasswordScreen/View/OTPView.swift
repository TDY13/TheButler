//
//  OTPView.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 02.07.2022.
//

import Foundation
import UIKit
protocol OTPViewDelegate: AnyObject {
    func didFullCodeCompletion(_ otpView: OTPView)
}

class OTPView: UIView {
    weak var delegate: OTPViewDelegate?
    
    var digitViews: [UILabel] = []
    
    var code: String? {
        return textField.text
    }
    
    var isError: Bool = false {
        didSet {
            handleErrorUI(isError)
        }
    }
    
    let textField: UITextField = {
        let obj = UITextField()
        obj.isHidden = true
        obj.keyboardType = .numberPad
        return obj
    }()
    
    private lazy var stackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: digitViews)
        obj.axis = .horizontal
        obj.spacing = 11
        obj.distribution = .fillEqually
        obj.semanticContentAttribute = .forceLeftToRight
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initDigits()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func initDigits() {
        for i in 0...3 {
            digitViews.append(initLabel())
        }
    }
    
    private func initLabel() -> UILabel {
        let obj = UILabel()
        obj.font = .skModernist(type: .bold, ofSize: 16)
        obj.textColor = .black
        obj.textAlignment = .center
        obj.backgroundColor = .TextFieldColor.general
        obj.layer.cornerRadius = 15
        obj.clipsToBounds = true
        return obj
    }
    
    private func setup() {
        addSubview(textField)
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textField.addTarget(self, action: #selector(didTextFieldChanged(_:)), for: .editingChanged)
    }
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        textField.becomeFirstResponder()
    }
    
    @objc func didTextFieldChanged(_ sender: UITextField) {
        guard var code = sender.text else {
            return
        }
        if code.count == 0 {
            delegate?.didFullCodeCompletion(self)
        } else if code.count > 4 {
            code.removeLast()
        } else {
            if code.count == 4 {
                delegate?.didFullCodeCompletion(self)
                textField.resignFirstResponder()
            }
        }
        digitViews.enumerated().forEach { index, item in
            item.text = (code.count-1 >= index ? String(code[code.index(code.startIndex, offsetBy: index)]) : "")
        }
    }
    
    private func handleErrorUI(_ isError: Bool) {
        colorСhanger()
    }
    
    private func colorСhanger() {
        digitViews.self.forEach { label in
            label.backgroundColor = .TextFieldColor.error
            label.textColor = .TextColor.redError
        }
    }
}
