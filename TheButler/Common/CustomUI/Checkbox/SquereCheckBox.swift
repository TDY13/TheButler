//
//  SquereCheckBox.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 17.06.2022.
//

import UIKit
class SquereCheckbox: UIButton {
    private let checkboxImageView: UIImageView = {
        let obj = UIImageView()
        return obj
    }()
    
    private let checkBoxLabel: UILabel = {
        let obj = UILabel()
        obj.font = .skModernist(type: .regular, ofSize: 12)
        return obj
    }()
    
    override var isSelected: Bool {
        didSet {
            checkBoxLabel.textColor = isSelected ?
                .TextColor.darkBlue :
                .TextColor.lightGrey
            checkboxImageView.image = isSelected ?
            UIImage(named: .Image.fullSquere) :
            UIImage(named: .Image.emptySquere)
        }
    }
    
    var checkboxTitle: String = "" {
        didSet {
            checkBoxLabel.text = checkboxTitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        isSelected = false
        
        addSubview(checkboxImageView)
        addSubview(checkBoxLabel)
        
        checkboxImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        checkBoxLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalTo(checkboxImageView.snp.trailing).offset(10)
        }
    }
}
