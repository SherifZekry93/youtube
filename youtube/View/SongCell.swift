//
//  File.swift
//  youtube
//
//  Created by Sherif  Wagih on 9/6/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class SongCell: BaseCell {
    var constraint:NSLayoutConstraint?
    var song:Song?{
        didSet{
            if let imageName = song?.thumbnail_image_name
            {
                thumbnailImageView.loadImageUsingUrlString(imageName: imageName)
            }
            if let title = song?.title
            {
                let size = CGSize(width:frame.width - 16 - 44 - 8 - 16,height:1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)], context: nil)
                if estimatedRect.size.height < 20
                {
                    constraint?.constant = -35
                }
                else
                {
                    constraint?.constant = -55
                }
                titleLabel.text = title
            }
            if let profileImage = song?.channel?.profile_image_name
            {
                userProfileimageView.loadImageUsingUrlString(imageName: profileImage)
            }
            guard let channelName = song?.channel?.name else {return}
            guard let numOfViews = song?.number_of_views else { return }
            let nsViews = NSNumber(integerLiteral: numOfViews)
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
          
            
            subTitleLabel.text = "\(channelName) - \(formatter.string(from: nsViews)!) Views - 2 years Ago"
            
            let size = CGSize(width:frame.width - 16 - 44 - 8 - 16,height:1000)
            
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let estimatedRect = NSString(string: subTitleLabel.text!).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)], context: nil)
            if estimatedRect.size.height > 20
            {
                constraint?.constant += -15
            }
        }
        
    }
    let thumbnailImageView:CustomImageView = {
       let imageView = CustomImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let userProfileimageView:CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 22
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let sepratorView:UIView = {
        let uiView = UIView()
     
        uiView.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
        return uiView
    }()
    let titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        return label
    }()
    let subTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    override func setupViews()
    {
        backgroundColor = .clear
        addSubview(thumbnailImageView)
        addSubview(sepratorView)
        addSubview(userProfileimageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        thumbnailImageView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: userProfileimageView.topAnchor, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 8, rightConstant: 16)
        sepratorView.setHeightConstraint(height: 1)
        sepratorView.anchorWithConstantsToTop(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,  leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        userProfileimageView.anchorWithConstantsToTop(top: thumbnailImageView.bottomAnchor, left: thumbnailImageView.leftAnchor,topConstant: 8, leftConstant: 0)
        constraint = userProfileimageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        constraint?.isActive = true
        userProfileimageView.setHeightConstraint(height: 44)
        userProfileimageView.setWidthAnchor(width: 44)
        titleLabel.anchorWithConstantsToTop(top: userProfileimageView.topAnchor, left: userProfileimageView.rightAnchor, right: rightAnchor, topConstant: 0, leftConstant: 8, rightConstant: 16)
        subTitleLabel.anchorWithConstantsToTop(top: titleLabel.bottomAnchor, left: userProfileimageView.rightAnchor, right: rightAnchor, topConstant: 5, leftConstant: 8, rightConstant: 16)
        subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant:9)
    }
    override func prepareForReuse()
    {
        
    }
}

