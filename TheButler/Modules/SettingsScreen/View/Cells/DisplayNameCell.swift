//
//  File.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 15.06.2022.
//

import UIKit

class DisplayNameCell: UITableViewCell, Reusable {
    var settingsIcon: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.profile)
        return obj
    }()
    
    var titleLabel: UILabel = {
        var obj = UILabel()
        obj.text = .Text.yourDisplayName
        obj.font = .skModernist(type: .bold, ofSize: 16)
        obj.textColor = .TextColor.darkBlue
        return obj
    }()
    
    var descriptionLabel: UILabel = {
        var obj = UILabel()
        obj.text = .Text.nameWillBeDisplay
        obj.font = .skModernist(type: .regular, ofSize: 14)
        obj.textColor = .TextColor.lightGrey
        return obj
    }()
    
    var displayNameTextField: TextFieldWithPadding = {
        var obj = TextFieldWithPadding()
        obj.text = .Text.johnDoe
        obj.returnKeyType = .done
        obj.backgroundColor = .TextFieldColor.general
        obj.clipsToBounds = true
        obj.layer.cornerRadius = 15
        obj.textPadding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 15)
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
    
    private func setup() {
        selectionStyle = .none
        contentView.addSubview(settingsIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(displayNameTextField)
        
        settingsIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(snp.leading).offset(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(settingsIcon.snp.top)
            make.leading.equalTo(settingsIcon.snp.trailing).offset(18)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        displayNameTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.equalTo(snp.leading).offset(66)
            make.trailing.equalTo(snp.trailing).offset(-28)
            make.height.equalTo(47)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}

