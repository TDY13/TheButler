//
//  SettingsSwitchCell.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 15.06.2022.
//

import UIKit

class SettingsSwitchCell: UITableViewCell, Reusable {
    var settingsIcon: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.notification)
        return obj
    }()
    
    var titleLabel: UILabel = {
        var obj = UILabel()
        obj.text = .Text.doNotDisturb
        obj.textColor = .TextColor.darkBlue
        obj.font = .skModernist(type: .bold, ofSize: 16)
        return obj
    }()
    
    var descriptionLabel: UILabel = {
        var obj = UILabel()
        obj.text = .Text.youWillNotBeNotified
        obj.textColor = .TextColor.lightGrey
        obj.font = .skModernist(type: .regular, ofSize: 14)
        obj.numberOfLines = 0
        return obj
    }()
    
    var notificationSwitch: UISwitch = {
        var obj = UISwitch()
        obj.isOn = false
        obj.clipsToBounds = true
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        selectionStyle = .none
        contentView.addSubview(settingsIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(notificationSwitch)
        
        settingsIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(31)
            make.top.equalToSuperview().offset(38)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(settingsIcon.snp.trailing).offset(17.5)
            make.top.equalToSuperview().offset(38)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalToSuperview().offset(-22)
        }
        
        notificationSwitch.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(36)
            make.trailing.equalTo(snp.trailing).offset(-28)
        }
    }
}


