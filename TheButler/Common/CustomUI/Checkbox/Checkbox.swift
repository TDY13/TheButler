//
//  Checkbox.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 07.06.2022.
//

import Foundation
import UIKit
class Checkbox: UIButton {    
    private let checkboxImageView: UIImageView = {
        let obj = UIImageView()
        return obj
    }()
    
    private let checkBoxLabel: UILabel = {
        let obj = UILabel()
        obj.font = .skModernist(type: .regular, ofSize: 15)
        return obj
    }()
    
    override var isSelected: Bool {
        didSet {
            checkBoxLabel.textColor = isSelected ?
                .TextColor.darkBlue :
                .TextColor.lightGrey
            checkboxImageView.image = isSelected ?
            UIImage(named: .Image.onIndicator) :
            UIImage(named: .Image.offIndicator)
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
            make.leading.equalTo(checkboxImageView.snp.trailing).offset(5)
        }
    }
}
