//
//  PickerView.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 01.06.2022.
//

import UIKit

final class PickerView: UIView {
    
    private let iconView: UIImageView = {
        var obj = UIImageView()
        obj.contentMode = .scaleAspectFill
        obj.layer.cornerRadius = 10
        return obj
    }()
    private let label: UILabel = {
        var obj = UILabel()
        obj.textColor = .TextColor.darkBlue
        obj.font = .skModernist(type: .bold, ofSize: 15)
        return obj
    }()
    private let countryCode: UILabel = {
        var obj = UILabel()
        obj.textColor = .TextColor.darkBlue
        obj.font = .skModernist(type: .bold, ofSize: 15)
        return obj
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(iconView)
        addSubview(label)
        addSubview(countryCode)
        
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.centerY.equalTo(snp.centerY)
            make.height.width.equalTo(20)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(20)
            make.top.bottom.equalToSuperview()
        }
        
        countryCode.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-25)
            make.top.bottom.equalToSuperview()
        }
    }
    
    static func create(icon: UIImage, title: String, code: String) -> PickerView {
        let numberView = PickerView()
        numberView.iconView.image = icon
        numberView.label.text = title
        numberView.countryCode.text = code
        return numberView
    }
}
