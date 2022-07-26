//
//  ChooseApartmentsTableViewCell.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 14.06.2022.
//

import UIKit

class ChooseApartmentsTableViewCell: UITableViewCell {
    static let id = String(describing: ChooseApartmentsTableViewCell.self)
    
    var apartmanImage: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.apartman)
        return obj
    }()
    
    var clientNameLabel: UILabel = {
        var obj = UILabel()
        obj.text = "Bares Family"
        obj.textColor = .TextColor.darkBlue
        obj.font = .skModernist(type: .bold, ofSize: 16)
        return obj
    }()
    
    var adressLabel: UILabel = {
        var obj = UILabel()
        obj.text = "200 5th Ave"
        obj.textColor = .TextColor.lightGrey
        obj.font = .skModernist(type: .regular, ofSize: 14)
        return obj
    }()
    
    var nextPointerImage: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.nextPointer)
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
        contentView.addSubview(apartmanImage)
        contentView.addSubview(clientNameLabel)
        contentView.addSubview(adressLabel)
        contentView.addSubview(nextPointerImage)
        
        apartmanImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview()
        }
        clientNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(apartmanImage.snp.trailing).offset(18)
        }
        adressLabel.snp.makeConstraints {
            $0.top.equalTo(clientNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(clientNameLabel.snp.leading)
        }
        nextPointerImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-26)
        }
    }
}
