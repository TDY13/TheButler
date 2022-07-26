//
//  CodeVerificationView.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 03.06.2022.
//

import UIKit

class CodeVerificationView: UIView {
    var containerView: UIView = {
        var obj = UIView()
        return obj
    }()
    
    var backButton: UIButton = {
        var obj = UIButton()
        obj.setImage(UIImage(named: .Image.backPointer), for: .normal)
        obj.backgroundColor = .white
        obj.layer.borderColor = .BorderColor.lightGrey
        obj.layer.cornerRadius = 13
        obj.layer.borderWidth = 1
        return obj
    }()
    
    var logoImage: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.USA)
        return obj
    }()
    
    var shieldImage: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.lock)
        return obj
    }()
    
    var descriptionLabel: UILabel = {
        var obj = UILabel()
        obj.font = .skModernist(type: .bold, ofSize: 35)
        obj.text = .Text.enterYourVerificationCode
        obj.numberOfLines = 2
        return obj
    }()
    
    let otpView: OTPView = {
        let obj = OTPView()
        return obj
    }()
    
    var errorAlertLabel: UILabel = {
        var obj = UILabel()
        obj.text = .Text.pleaseEnterValidCode
        obj.font = .skModernist(type: .regular, ofSize: 14)
        obj.textColor = UIColor(red: 255/255, green: 0/255, blue: 46/255, alpha: 1)
        obj.isHidden = true
        return obj
    }()
    
    var verifyButton: UIButton = {
        var obj = UIButton()
        obj.setImage(UIImage(named: .Image.RectangleWithShadow), for: .normal)
        return obj
    }()
    
    var verifyLabel: UILabel = {
        var obj = UILabel()
        obj.font = UIFont(name: SkModernistFontType.bold.rawValue, size: 16)
        obj.textColor = .white
        obj.text = .Text.verify
        return obj
    }()
    
    var tickImage: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.tick)
        return obj
    }()
    
    let spinner: UIActivityIndicatorView = {
        var obj = UIActivityIndicatorView(style: .large)
        obj.hidesWhenStopped = true
        return obj
    }()
    
    let loadingView: UIView = {
        var obj = UIView()
        obj.alpha = 0.25
        obj.backgroundColor = .black
        obj.clipsToBounds = true
        obj.layer.cornerRadius = 13
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .white
        
        addSubview(backButton)
        addSubview(logoImage)
        addSubview(shieldImage)
        addSubview(containerView)
        addSubview(spinner)
        spinner.addSubview(loadingView)
        
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(otpView)
        containerView.addSubview(errorAlertLabel)
        
        containerView.addSubview(verifyButton)
        verifyButton.addSubview(verifyLabel)
        verifyButton.addSubview(tickImage)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(66)
            $0.leading.equalTo(snp.leading).offset(22)
            $0.height.width.equalTo(45)
        }
        
        logoImage.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(20)
            $0.centerY.equalTo(backButton)
        }
        
        shieldImage.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(25)
            $0.right.equalTo(snp.right).offset(-101)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(227)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leading).offset(20)
            $0.top.equalTo(containerView.snp.top)
        }
        
        otpView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(28)
            make.height.equalTo(55)
        }
        
        errorAlertLabel.snp.makeConstraints {
            $0.top.equalTo(otpView.snp.bottom).offset(8)
            $0.leading.equalTo(otpView.snp.leading)
        }
        
        verifyButton.snp.makeConstraints {
            $0.top.equalTo(otpView.snp.bottom).offset(67)
            $0.left.right.equalToSuperview()
        }
        
        verifyLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(49)
            $0.top.equalToSuperview().offset(22)
        }
        
        tickImage.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-47)
            $0.centerY.equalTo(verifyLabel)
        }
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        loadingView.snp.makeConstraints { make in
            make.edges.equalTo(snp.edges)
        }
    }
}

