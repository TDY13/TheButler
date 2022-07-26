//
//  HomeTableViewCell.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 08.06.2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    static let id = String(describing: HomeTableViewCell.self)
    
    var containerView: UIView = {
        var obj = UIView()
        obj.layer.cornerRadius = 15
        obj.layer.borderWidth = 1
        obj.layer.borderColor = .BorderColor.lightGrey
        return obj
    }()
    
    var leftStatusImage: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.leftBlue)
        obj.contentMode = .scaleAspectFill
        return obj
    }()
    
    var doorNameLabel: UILabel = {
        var obj = UILabel()
        obj.font = .skModernist(type: .bold, ofSize: 16)
        obj.textColor = .TextColor.darkBlue
        obj.text = .Text.frontDoor
        return obj
    }()
    
    var doorLocationLabel: UILabel = {
        var obj = UILabel()
        obj.textColor = .TextColor.lightGrey
        obj.font = .skModernist(type: .regular, ofSize: 14)
        obj.text = .Text.home
        return obj
    }()
    
    var lockStatusLabel: UILabel = {
        var obj = UILabel()
        obj.textColor = .TextColor.darkBlue
        obj.font = .skModernist(type: .bold, ofSize: 15)
        obj.text = .Text.locked
        return obj
    }()
    
    var rightStatusImage: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.rightStatus)
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        selectionStyle = .none
        
        addSubview(containerView)
        containerView.addSubview(leftStatusImage)
        containerView.addSubview(doorNameLabel)
        containerView.addSubview(doorLocationLabel)
        containerView.addSubview(lockStatusLabel)
        containerView.addSubview(rightStatusImage)
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
            $0.top.equalToSuperview().offset(8)
        }
        
        leftStatusImage.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(19)
            $0.leading.equalTo(containerView.snp.leading).offset(23)
            $0.height.width.equalTo(41)
        }
        
        doorNameLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(22)
            $0.leading.equalTo(leftStatusImage.snp.trailing).offset(14)
        }
        
        doorLocationLabel.snp.makeConstraints {
            $0.top.equalTo(doorNameLabel.snp.bottom)
            $0.leading.equalTo(doorNameLabel.snp.leading)
        }
        
        lockStatusLabel.snp.makeConstraints {
            $0.bottom.equalTo(snp.bottom).offset(-15)
            $0.centerX.equalTo(snp.centerX)
        }
        
        rightStatusImage.snp.makeConstraints {
            $0.trailing.equalTo(snp.trailing).offset(-16)
            $0.top.equalTo(snp.top).offset(19)
        }
    }
}

