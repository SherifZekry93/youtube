//
//  BaseCellClass.swift
//  youtube
//
//  Created by Sherif  Wagih on 9/6/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews()
    {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
