//
//  MenuBarItemCell.swift
//  youtube
//
//  Created by Sherif  Wagih on 9/6/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class MenubarItemCell : BaseCell
{
    let imageView:UIImageView = {
      let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFit
        return iv;
    }()
    override func setupViews()
    {
        addSubview(imageView)
        imageView.anchorToTop(top: topAnchor, left: leftAnchor, right: rightAnchor)
        imageView.setHeightConstraint(height: 35)
    }
    override var isHighlighted: Bool{
        didSet{
            imageView.tintColor = isHighlighted ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    override var isSelected: Bool{
        didSet{
            imageView.tintColor = isSelected ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
}
