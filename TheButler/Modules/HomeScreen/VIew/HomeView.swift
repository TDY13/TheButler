//
//  HomeView.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 07.06.2022.
//

import UIKit

class HomeView: UIView {
    var logoView: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.USA)
        return obj
    }()
    
    var settingsButton: UIButton = {
        var obj = UIButton()
        obj.setImage(UIImage(named: .Image.setting), for: .normal)
        obj.layer.borderWidth = 1
        obj.layer.borderColor = .BorderColor.lightGrey
        obj.layer.cornerRadius = 13
        return obj
    }()
    
    var homeImage: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.home)
        return obj
    }()
    
    var welcomeLabel: UILabel = {
        var obj = UILabel()
        obj.font = .skModernist(type: .bold, ofSize: 35)
        obj.text = .Text.welcome
        return obj
    }()
    
    var doorsLabel: UILabel = {
        var obj = UILabel()
        obj.font = .skModernist(type: .bold, ofSize: 20)
        obj.text = .Text.myDoors
        return obj
    }()
    
    var tableView: UITableView = {
        var obj = UITableView()
        obj.separatorStyle = .none
        obj.showsVerticalScrollIndicator = false
        return obj
    }()
    
    var gradientView: UIImageView = {
        var obj = UIImageView()
        obj.image = UIImage(named: .Image.gradient)
        return obj
    }()
    
    var passwordButton: UIButton = {
        var obj = UIButton()
        obj.setImage(UIImage(named: .Image.password), for: .normal)
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
        addSubview(logoView)
        addSubview(settingsButton)
        addSubview(welcomeLabel)
        addSubview(homeImage)
        addSubview(doorsLabel)
        addSubview(tableView)
        addSubview(gradientView)
        gradientView.addSubview(passwordButton)
        
        logoView.snp.makeConstraints {
            $0.top.equalTo(77)
            $0.leading.equalTo(24)
        }
        
        settingsButton.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(63)
            $0.trailing.equalTo(snp.trailing).offset(-27)
            $0.height.width.equalTo(45)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom).offset(63)
            $0.leading.equalTo(logoView.snp.leading)
        }
        
        homeImage.snp.makeConstraints {
            $0.top.equalTo(settingsButton.snp.bottom)
            $0.trailing.equalTo(snp.trailing).offset(5)
        }
        
        doorsLabel.snp.makeConstraints {
            $0.top.equalTo(homeImage.snp.bottom).offset(31)
            $0.leading.equalTo(logoView.snp.leading)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(doorsLabel.snp.bottom).offset(28)
            $0.leading.equalTo(snp.leading).offset(20)
            $0.trailing.equalTo(snp.trailing).offset(-27)
            $0.bottom.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(75)
        }
        
        passwordButton.snp.makeConstraints {
            $0.trailing.equalTo(gradientView.snp.trailing).offset(-48)
            $0.bottom.equalTo(gradientView.snp.bottom).offset(-18)
            $0.height.width.equalTo(18.5)
        }
    }
}
