//
//  ResidentTableViewCell.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 21.06.2022.
//

import UIKit

protocol ResidentTableViewCellDelegate: AnyObject {
    func didRemoveButtonTapped(cell: ResidentTableViewCell)
    func didManagerButtonTapped(cell: ResidentTableViewCell)
    func didHiddenButtonTapped(cell: ResidentTableViewCell)
    func didHeardButtonTapped(cell: ResidentTableViewCell)
}

class ResidentTableViewCell: UITableViewCell {
    var model: ResidentModel? {
        didSet {
            if let model = model {
                nameLabel.text = model.name
                phoneNumberLabel.text = model.mobileNumber
                managerButton.isSelected = model.manager
                hiddenButton.isSelected = model.hidden
                heartButton.isSelected = model.heart
            }
        }
    }
    
    weak var delegate: ResidentTableViewCellDelegate?
    
    static let id = String(describing: ResidentTableViewCell.self)
    
    var containerView: UIView = {
        var obj = UIView()
        obj.layer.cornerRadius = 15
        obj.layer.borderWidth = 1
        obj.layer.borderColor = .BorderColor.lightGrey
        return obj
    }()
    
    var serialNumberView: UIImageView = {
        let obj = UIImageView()
        obj.clipsToBounds = true
        obj.layer.cornerRadius = 21.5
        return obj
    }()
    
    var serialNumberLabel: UILabel = {
        let obj = UILabel()
        obj.font = .skModernist(type: .bold, ofSize: 14)
        obj.textColor = .white
        return obj
    }()
    
    var nameLabel: UILabel = {
        var obj = UILabel()
        obj.textColor = .TextColor.darkBlue
        obj.font = .skModernist(type: .bold, ofSize: 16)
        obj.text = "John Doe"
        return obj
    }()
    
    var phoneNumberLabel: UILabel = {
        var obj = UILabel()
        obj.textColor = .TextColor.lightGrey
        obj.font = .skModernist(type: .regular, ofSize: 14)
        obj.text = "+38095"
        return obj
    }()
    
    var managerButton: SquereCheckbox = {
        var obj = SquereCheckbox()
        obj.checkboxTitle = .Text.manager
        obj.setTitleColor(.TextColor.lightGrey, for: .normal)
        obj.setTitleColor(.TextColor.darkBlue, for: .selected)
        obj.isSelected = false
        return obj
    }()
    
    var hiddenButton: SquereCheckbox = {
        var obj = SquereCheckbox()
        obj.checkboxTitle = .Text.hidden
        obj.setTitleColor(.TextColor.lightGrey, for: .normal)
        obj.setTitleColor(.TextColor.darkBlue, for: .selected)
        obj.isSelected = false
        return obj
    }()
    
    var heartButton: UIButton = {
        var obj = UIButton()
        obj.setImage(UIImage(named: .Image.heart), for: .normal)
        obj.setImage(UIImage(named: .Image.heartRed), for: .selected)
        return obj
    }()
    
    var removeCellButton: UIButton = {
        var obj = UIButton()
        obj.setImage(UIImage(named: .Image.bin), for: .normal)
        return obj
    }()
    
    var gradientBG: CAGradientLayer = {
        let obj = CAGradientLayer()
        var leftColor = UIColor.GradientBlue.left
        var rightColor = UIColor.GradientBlue.right
        obj.colors = [leftColor, rightColor]
        obj.startPoint = CGPoint(x: 0, y: 0.5)
        obj.endPoint = CGPoint(x: 1, y: 0.5)
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
        serialNumberView.layer.insertSublayer(gradientBG, at: 0)
        
        contentView.addSubview(containerView)
        containerView.addSubview(serialNumberView)
        serialNumberView.addSubview(serialNumberLabel)
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(phoneNumberLabel)
        containerView.addSubview(managerButton)
        containerView.addSubview(hiddenButton)
        containerView.addSubview(heartButton)
        containerView.addSubview(removeCellButton)
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.top.equalToSuperview().inset(8)
        }
        
        serialNumberView.snp.makeConstraints {
            $0.height.width.equalTo(41)
            $0.leading.equalToSuperview().offset(23)
            $0.top.equalToSuperview().offset(19)
        }
        
        serialNumberLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(serialNumberView.snp.trailing).offset(18)
            $0.top.equalToSuperview().offset(22)
        }
        
        removeCellButton.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-22.5)
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(1)
        }
        
        managerButton.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(20)
        }
        
        hiddenButton.snp.makeConstraints {
            $0.leading.equalTo(managerButton.snp.trailing).offset(23)
            $0.centerY.equalTo(managerButton)
            $0.height.equalTo(20)
        }
        
        heartButton.snp.makeConstraints {
            $0.centerY.equalTo(hiddenButton)
            $0.bottom.equalToSuperview().offset(-18)
            $0.trailing.equalToSuperview().offset(-22)
        }
        
        removeCellButton.addTarget(self, action: #selector(didRemoveButtonTapped(_:)), for: .touchUpInside)
        managerButton.addTarget(self, action: #selector(didManagerButtonTapped(_:)), for: .touchUpInside)
        hiddenButton.addTarget(self, action: #selector(didHiddenButtonTapped(_:)), for: .touchUpInside)
        heartButton.addTarget(self, action: #selector(didHeartButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientBG.frame = serialNumberView.bounds
    }
    
}

//MARK: targets
extension ResidentTableViewCell {
    @objc private func didRemoveButtonTapped(_ sender: UIButton) {
        delegate?.didRemoveButtonTapped(cell: self)
    }
    
    @objc private func didManagerButtonTapped(_ sender: UIButton) {
        delegate?.didManagerButtonTapped(cell: self)
    }
    
    @objc private func didHiddenButtonTapped(_ sender: UIButton) {
        delegate?.didHiddenButtonTapped(cell: self)
    }
    
    @objc private func didHeartButtonTapped(_ sender: UIButton) {
        delegate?.didHeardButtonTapped(cell: self)
    }
    
}
