//
//  MenuBar.swift
//  youtube
//
//  Created by Sherif  Wagih on 9/6/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class Menubar: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    var homeController:HomeController?
    let cellId = "menubarItemCellId"
    let images = ["home","trending","subscriptions","account"]
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
       /* let x = CGFloat(indexPath.item) * frame.width / 4
        self.barLeftAnchor?.constant = x
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        */
        homeController?.jumpToIndex(index: indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenubarItemCell
        cell.imageView.image = UIImage(named: images[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.register(MenubarItemCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        setupHorizontalMenuBar()
    }
    var barLeftAnchor:NSLayoutConstraint?
    func setupHorizontalMenuBar()
    {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = .white//UIColor.white
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        horizontalBarView.anchorToTop(bottom: bottomAnchor)
        barLeftAnchor = horizontalBarView.leftAnchor.constraint(equalTo: leftAnchor)
        barLeftAnchor?.isActive = true
        horizontalBarView.setHeightConstraint(height: 5)
        horizontalBarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
