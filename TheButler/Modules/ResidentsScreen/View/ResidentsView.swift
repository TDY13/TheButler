//
//  ResidentsView.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 14.06.2022.
//

import UIKit

class ResidentsView: UIView {
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
    
    let apartNameLabel: UILabel = {
        var obj = UILabel()
        obj.font = .skModernist(type: .bold, ofSize: 35)
        obj.text = .Text.myApartName
        return obj
    }()
    
    var dividingLineView: UIView = {
        var view = UIView()
        view.backgroundColor = .Background.lightGrey
        return view
    }()
    
    var residentsLabel: UILabel = {
        var obj = UILabel()
        obj.font = .skModernist(type: .bold, ofSize: 20)
        obj.text = .Text.residents
        return obj
    }()
    
    var addResidentsButton: UIButton = {
        var obj = UIButton()
        obj.layer.borderWidth = 1
        obj.layer.borderColor = .BorderColor.lightGrey
        obj.layer.cornerRadius = 13
        obj.setImage(UIImage(named: .Image.edit), for: .normal)
        return obj
    }()
    
    let tableView: UITableView = {
        let obj = UITableView()
        obj.showsVerticalScrollIndicator = false
        obj.separatorStyle = .none
        obj.rowHeight = UITableView.automaticDimension
        return obj
    }()
    
    let addResidentView: AddResidentsView = {
        var obj = AddResidentsView()
        obj.isHidden = true
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
        addSubview(apartNameLabel)
        addSubview(dividingLineView)
        addSubview(residentsLabel)
        addSubview(addResidentsButton)
        addSubview(tableView)
        addSubview(addResidentView)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(66)
            $0.leading.equalTo(snp.leading).offset(25)
            $0.height.width.equalTo(45)
        }
        
        logoImage.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(20)
            $0.top.equalTo(snp.top).offset(79)
        }
        
        apartNameLabel.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.leading)
            $0.top.equalTo(backButton.snp.bottom).offset(46)
        }
        
        dividingLineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(apartNameLabel.snp.bottom).offset(42)
        }
        
        residentsLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalTo(dividingLineView.snp.bottom).offset(43)
        }
        
        addResidentsButton.snp.makeConstraints {
            $0.height.width.equalTo(45)
            $0.top.equalTo(dividingLineView.snp.bottom).offset(32)
            $0.trailing.equalToSuperview().offset(-29)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(residentsLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        addResidentView.snp.makeConstraints {
            $0.top.trailing.leading.bottom.equalToSuperview()
        }
    }
}
