//
//  SettingsTableViewCell.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 15.06.2022.
//

import Foundation

import UIKit

class SettingsTableViewCell: UITableViewCell, Reusable {
    var settingsIcon: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.edit)
        obj.contentMode = .scaleAspectFill
        return obj
    }()
    
    var titleLabel: UILabel = {
        var obj = UILabel()
        obj.text = .Text.editResidents
        obj.textColor = .TextColor.darkBlue
        obj.font = .skModernist(type: .bold, ofSize: 16)
        return obj
    }()
    
    var descriptionLabel: UILabel = {
        var obj = UILabel()
        obj.text = .Text.editResidentsAndInfo
        obj.textColor = .TextColor.lightGrey
        obj.font = .skModernist(type: .regular, ofSize: 14)
        return obj
    }()
    
    var arrowImageView: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.nextPointer)
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
        contentView.addSubview(arrowImageView)
        
        settingsIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.leading.equalToSuperview().offset(32)
            make.height.width.equalTo(18)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.leading.equalTo(settingsIcon.snp.trailing).offset(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalToSuperview().offset(-22)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(snp.trailing).offset(-28)
        }
    }
}

