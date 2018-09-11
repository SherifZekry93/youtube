//
//  SettingsLauncher.swift
//  youtube
//
//  Created by Sherif  Wagih on 9/7/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

enum SettingName:String
{
    case SettingNameEnum = "Setting"
    case T_SEnum = "Terms & privacy policy"
    case Send_FeedBackEnum = "Send Feedback"
    case HelpEnum = "Help"
    case Switch_AccountEnum = "Switch Account"
    case Cancel_Dismiss = "Cancel & Dismiss"
}
class SettingLauncher:NSObject,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    var homeController :HomeController?
    private var cellId = "menuItemCellId"
    let allSettings = [Setting(name: .SettingNameEnum,imageName:"settings"),Setting(name: .T_SEnum,imageName:"privacy"),Setting(name: .Send_FeedBackEnum,imageName:"feedback"),Setting(name: .HelpEnum,imageName:"help"),Setting(name: .Switch_AccountEnum,imageName:"switch_account"),Setting(name: .Cancel_Dismiss,imageName:"cancel")]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allSettings.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleDismiss { () -> () in
            
            let setting = self.allSettings[indexPath.item]
            self.homeController?.showControllerForSetting(for: setting)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingItemCell
        cell.setting = allSettings[indexPath.item]
        return cell
    }
    override init()
    {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingItemCell.self, forCellWithReuseIdentifier: cellId)
    }
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let blackView = UIView()
    @objc func handleMenu()
    {
        if let window = UIApplication.shared.keyWindow
        {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissByTarget)))
            UIView.animate(withDuration: 0.3)
            {
                self.blackView.alpha = 1
            }
            window.addSubview(collectionView)
            let height:CGFloat = 300
            let y = window.frame.height - 300
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            }, completion: nil)
            /*UIView.animate(withDuration: 0.3)
            {
                self.collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            }*/
            
        }
        
    }
    @objc func handleDismissByTarget()
    {
        handleDismiss()
    }
    func handleDismiss(_  completetionHandler:@escaping () -> () = {})
    {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow
            {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }) { (completed) in
            completetionHandler()
        }
        UIView.animate(withDuration: 0.3) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow
            {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
           }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     return CGSize(width: collectionView.frame.width, height: 300/6)
    }
}
