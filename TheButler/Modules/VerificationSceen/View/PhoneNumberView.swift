//
//  PhoneNumberView.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 31.05.2022.
//

import UIKit
import CoreTelephony

class PhoneNumberView: UIView {
    var containerPickerView: UIView = {
        var view = UIView()
        view.backgroundColor = .systemRed
        return view
    }()
    
    var titleButton: UIButton = {
        var obj = UIButton()
        obj.setTitle(.Text.selectYourCountry, for: .normal)
        obj.setTitleColor(.TextColor.darkBlue, for: .normal)
        obj.titleLabel?.font = .skModernist(type: .bold, ofSize: 18)
        obj.titleLabel?.textAlignment = .center
        return obj
    }()
    
    var dividingLineView: UIView = {
        var view = UIView()
        view.backgroundColor = .Background.lightGrey
        return view
    }()
    
    var phoneNumberPicker: UIPickerView = {
        var picker = UIPickerView()
        return picker
    }()
    
    var gradientBG: CAGradientLayer = {
        let obj = CAGradientLayer()
        var leftColor = CGColor.GradientBlue.left
        var rightColor = CGColor.GradientBlue.right
        obj.colors = [leftColor, rightColor]
        obj.startPoint = CGPoint(x: 0, y: 0.5)
        obj.endPoint = CGPoint(x: 1, y: 0.5)
        return obj
    }()
    
    var selectButton: UIButton = {
        var button = UIButton()
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        return button
    }()
    
    var selectLabel: UILabel = {
        var label = UILabel()
        label.text = .Text.select
        label.font = .skModernist(type: .bold, ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setup()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.backgroundColor  = .white
        addSubview(titleButton)
        addSubview(dividingLineView)
        addSubview(phoneNumberPicker)
        addSubview(selectButton)
        
        selectButton.layer.addSublayer(gradientBG)
        selectButton.addSubview(selectLabel)
        
        titleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        dividingLineView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(titleButton.snp.bottom).offset(22)
        }
        phoneNumberPicker.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(5)
            $0.top.equalTo(dividingLineView.snp.bottom).offset(20)
        }
        selectButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(70)
            $0.top.equalTo(phoneNumberPicker.snp.bottom).offset(20)
        }
        selectLabel.snp.makeConstraints {
            $0.centerX.equalTo(selectButton.snp.centerX)
            $0.top.equalTo(selectButton.snp.top).offset(20)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientBG.frame = selectButton.bounds
    }
}

extension PhoneNumberView {
    func setup() {
        let countryCode: String
        if let carrier = CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.first?.value,
           let code = carrier.isoCountryCode?.uppercased() {
            countryCode = code
        } else {
            countryCode = "USA"
        }
        phoneNumberPicker.selectRow(0, inComponent: 0, animated: true)
        phoneNumberPicker.subviews[1].backgroundColor = .clear
    }
}

