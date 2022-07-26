//
//  SettingsView.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 08.06.2022.
//

import UIKit

class SettingsView: UIView {
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
    
    var gearImage: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.gear)
        return obj
    }()
    
    let settingsLabel: UILabel = {
        var obj = UILabel()
        obj.font = .skModernist(type: .bold, ofSize: 35)
        obj.text = .Text.settings
        return obj
    }()
    
    let settingsTableView: UITableView = {
        let obj = UITableView()
        return obj
    }()
    
    var logoutButton: UIButton = {
        var obj = UIButton()
        obj.backgroundColor = .Background.lightRed?.withAlphaComponent(0.07)
        obj.setTitle(.Text.logout, for: .normal)
        obj.setTitleColor(.TextColor.redError, for: .normal)
        obj.layer.cornerRadius = 15
        return obj
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
        addSubview(backButton)
        addSubview(logoImage)
        addSubview(gearImage)
        addSubview(settingsLabel)
        addSubview(settingsTableView)
        addSubview(logoutButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(66)
            $0.leading.equalTo(snp.leading).offset(25)
            $0.height.width.equalTo(45)
        }
        
        logoImage.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(20)
            $0.top.equalTo(snp.top).offset(79)
        }
        
        gearImage.snp.makeConstraints {
            $0.trailing.equalTo(snp.trailing)
            $0.top.equalTo(snp.top).offset(106)
        }
        
        settingsLabel.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.leading)
            $0.top.equalTo(backButton.snp.bottom).offset(46)
        }
        
        settingsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(settingsLabel.snp.bottom).offset(85)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(settingsTableView.snp.bottom).offset(42)
            $0.leading.equalTo(snp.leading).offset(25)
            $0.trailing.equalTo(snp.trailing).offset(-26)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().offset(-51)
        }
    }
}

