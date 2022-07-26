//
//  ChooseApartmentsView.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 14.06.2022.
//

import UIKit

class ChooseApartmentView: UIView {
    
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
    
    var tickImage: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.mask)
        return obj
    }()
    
    let apartmentsLabel: UILabel = {
        var obj = UILabel()
        obj.font = .skModernist(type: .bold, ofSize: 35)
        obj.text = .Text.chooseApartment
        obj.numberOfLines = 0
        return obj
    }()
    
    var tableView: UITableView = {
        var obj = UITableView()
        obj.showsVerticalScrollIndicator = false
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(backButton)
        addSubview(logoImage)
        addSubview(tickImage)
        addSubview(apartmentsLabel)
        addSubview(tableView)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(66)
            $0.leading.equalTo(snp.leading).offset(25)
            $0.height.width.equalTo(45)
        }
        logoImage.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(20)
            $0.top.equalTo(snp.top).offset(79)
        }
        tickImage.snp.makeConstraints {
            $0.trailing.equalTo(snp.trailing)
            $0.top.equalTo(snp.top).offset(106)
        }
        apartmentsLabel.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.leading)
            $0.top.equalTo(backButton.snp.bottom).offset(46)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(apartmentsLabel.snp.bottom).offset(85)
            make.bottom.equalToSuperview()
        }
    }
}
