//
//  AddResidentsView.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 14.06.2022.
//

import UIKit

class AddResidentsView: UIView {
    var isShow: Bool = false
    
    let blurEffect: UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
        let obj = UIVisualEffectView(effect: blur)
        obj.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        obj.alpha = 0.9
        obj.isUserInteractionEnabled = true
        return obj
    }()
    
    let transparentView: UIView = {
        var obj = UIView()
        obj.isUserInteractionEnabled = true
        obj.backgroundColor = .black
        obj.alpha = 0.5
        return obj
    }()
    
    var containerView: UIView = {
        var obj = UIView()
        obj.clipsToBounds = true
        obj.layer.cornerRadius = 15
        obj.backgroundColor = .white
        return obj
    }()
    
    var addResidentLabeL: UILabel = {
        var obj = UILabel()
        obj.text = .Text.addResident
        obj.textColor = .TextColor.darkBlue
        obj.font = .skModernist(type: .bold, ofSize: 24)
        return obj
    }()
    
    var closeButton: UIButton = {
        var obj = UIButton()
        obj.layer.cornerRadius = 13
        obj.layer.borderWidth = 1
        obj.layer.borderColor = .BorderColor.lightGrey
        obj.setImage(UIImage(named: .Image.close), for: .normal)
        return obj
    }()
    
    var dividingLineView: UIView = {
        var view = UIView()
        view.backgroundColor = .Background.lightGrey
        return view
    }()
    
    var residentNameLabel: UILabel = {
        var obj = UILabel()
        obj.text = .Text.residentName
        obj.font = .skModernist(type: .bold, ofSize: 14)
        obj.textColor = .TextColor.darkBlue
        return obj
    }()
    
    var nameTextField: TextFieldWithPadding = {
        var obj = TextFieldWithPadding()
        obj.backgroundColor = .TextFieldColor.general
        obj.textAlignment = .left
        obj.layer.cornerRadius = 15
        obj.placeholder = .Text.enterResidentName
        obj.font = .skModernist(type: .regular, ofSize: 14)
        obj.textPadding = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        obj.returnKeyType = .done
        return obj
    }()
    
    var mobileNumberLabel: UILabel = {
        var obj = UILabel()
        obj.text = .Text.mobileNumber
        obj.font = .skModernist(type: .bold, ofSize: 14)
        obj.textColor = .TextColor.darkBlue
        return obj
    }()
    
    var mobileNumberTextField: TextFieldWithPadding = {
        var obj = TextFieldWithPadding()
        obj.backgroundColor = .TextFieldColor.general
        obj.textAlignment = .left
        obj.layer.cornerRadius = 15
        obj.font = .skModernist(type: .regular, ofSize: 14)
        obj.textPadding = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 45)
        obj.placeholder = .Text.enterResidentNumber
        obj.keyboardType = .phonePad
        return obj
    }()
    
    let contactListButton: UIButton = {
        let obj = UIButton()
        obj.setImage(UIImage(named: .Image.threeUsers), for: .normal)
        return obj
    }()
    
    var managerButton: SquereCheckbox = {
        var obj = SquereCheckbox()
        obj.checkboxTitle = .Text.manager
        return obj
    }()
    
    var hiddenButton: SquereCheckbox = {
        var obj = SquereCheckbox()
        obj.checkboxTitle = .Text.hidden
        return obj
    }()
    
    var heartButton: UIButton = {
        var obj = UIButton()
        obj.setImage(UIImage(named: .Image.heart), for: .normal)
        obj.setImage(UIImage(named: .Image.heartRed), for: .selected)
        return obj
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
    
    var addResidentButton: UIButton = {
        var obj = UIButton()
        obj.setTitle(.Text.addResident, for: .normal)
        obj.setTitleColor(.white, for: .normal)
        obj.titleLabel?.font = .skModernist(type: .bold, ofSize: 16)
        obj.clipsToBounds = true
        obj.layer.masksToBounds = true
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        isUserInteractionEnabled = true
        addResidentButton.layer.insertSublayer(gradientBG, at: 0)
        
        addSubview(transparentView)
        transparentView.addSubview(blurEffect)
        
        addSubview(containerView)
        containerView.addSubview(addResidentLabeL)
        containerView.addSubview(closeButton)
        containerView.addSubview(dividingLineView)
        containerView.addSubview(residentNameLabel)
        containerView.addSubview(nameTextField)
        containerView.addSubview(mobileNumberLabel)
        containerView.addSubview(mobileNumberTextField)
        mobileNumberTextField.addSubview(contactListButton)
        
        containerView.addSubview(managerButton)
        containerView.addSubview(hiddenButton)
        containerView.addSubview(heartButton)
        containerView.addSubview(addResidentButton)
        
        transparentView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.centerY.equalTo(transparentView.snp.centerY)
        }
        
        addResidentLabeL.snp.makeConstraints {
            $0.top.equalToSuperview().offset(34)
            $0.leading.equalToSuperview().offset(28)
        }
        
        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(addResidentLabeL)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.width.equalTo(45)
        }
        
        dividingLineView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(addResidentLabeL.snp.bottom).offset(34)
        }
        
        residentNameLabel.snp.makeConstraints {
            $0.top.equalTo(dividingLineView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(44)
        }
        
        nameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(residentNameLabel.snp.bottom).offset(10)
            $0.height.equalTo(47)
        }
        
        mobileNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(residentNameLabel.snp.leading)
            $0.top.equalTo(nameTextField.snp.bottom).offset(15)
        }
        
        mobileNumberTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(mobileNumberLabel.snp.bottom).offset(10)
            $0.height.equalTo(47)
        }
        
        contactListButton.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-19)
        }
        
        managerButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(29)
            $0.top.equalTo(mobileNumberTextField.snp.bottom).offset(30)
            $0.height.equalTo(20)
        }
        
        hiddenButton.snp.makeConstraints {
            $0.top.equalTo(managerButton)
            $0.leading.equalTo(managerButton.snp.trailing).offset(24)
            $0.height.equalTo(20)
        }
        
        heartButton.snp.makeConstraints {
            $0.top.equalTo(managerButton)
            $0.trailing.equalToSuperview().offset(-32.5)
        }
        
        addResidentButton.snp.makeConstraints {
            $0.top.equalTo(managerButton.snp.bottom).offset(43)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(64)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientBG.frame = addResidentButton.bounds
        blurEffect.frame = transparentView.bounds
    }
}
