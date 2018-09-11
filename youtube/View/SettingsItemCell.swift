//
//  MenuItemCell.swift
//  youtube
//
//  Created by Sherif  Wagih on 9/7/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class SettingItemCell: BaseCell {
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? .darkGray : .white
            nameLabel.textColor = isHighlighted ? .white: .black
            imageView.tintColor = isHighlighted ? .white: .gray
        }
    }
    var setting:Setting?{
        didSet{
            if let name = setting?.name
            {
                nameLabel.text = name.rawValue
            }
            if let imageName = setting?.imageName
            {
                imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = .gray
            }
        }
    }
    
    override func setupViews() {
        addSubview(nameLabel)
        addSubview(imageView)
        nameLabel.anchorToTop(top: topAnchor, bottom: bottomAnchor, right: rightAnchor)
        nameLabel.setWidthAnchor(width: frame.width - 60)
        imageView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nameLabel.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20)
    }
    let nameLabel : UILabel = {
       let label = UILabel()
       label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    let imageView:UIImageView = {
       let iv = UIImageView()
       iv.image = UIImage(named: "settings")
    iv.contentMode = .scaleAspectFit
       return iv
    }()
}
