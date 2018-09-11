//
//  ViewController.swift
//  youtube
//
//  Created by Sherif  Wagih on 9/6/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    let homeCellId = "homeCellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    let allCellIds = ["homeCellId","trendingCellId","subscriptionCellId","subscriptionCellId"]
    lazy var settingLauncher:SettingLauncher = {
       let launcher = SettingLauncher()
       launcher.homeController = self
        return launcher
    }()
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //fetchSongs()
        setupMenuBar()
        setupCollectionView()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 64 , height: view.frame.height))
        titleLabel.textColor = .white
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false
        setupBarButtons()    }
    func setupBarButtons()
    {
        let searhButton:UIBarButtonItem = {
            let searchImage = UIImage(named: "search_icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            let barButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
            return barButton
        }()
        let menuButton:UIBarButtonItem = {
            let menuImage = UIImage(named: "nav_more_icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            let barButton = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenu))
            return barButton
        }()
        navigationItem.rightBarButtonItems = [menuButton,searhButton]
    }
    @objc func handleMenu()
    {
        settingLauncher.handleMenu()
    }
    func showControllerForSetting(for setting:Setting)
    {
        if setting.name.rawValue != "" && setting.name != .Cancel_Dismiss
        {
        let dummySettingController = UIViewController()
            dummySettingController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = .white
        dummySettingController.view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.pushViewController(dummySettingController, animated: true)
        }
        
    }
    
    @objc func handleSearch()
    {
//        jumpToIndex(index:2)
    }
    func jumpToIndex(index:Int)
    {
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.homeController = self
        collectionView?.scrollToItem(at: indexPath, at:.centeredHorizontally, animated: true)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = allTitles[Int(index)]
    }
    lazy var menuBar : Menubar = {
        let mb = Menubar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.homeController = self
        return mb
    }()
    private func setupMenuBar()
    {
        navigationController?.hidesBarsOnSwipe = true
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 240, green: 32, blue: 31)
        view.addSubview(redView)
        redView.anchorToTop(top: view.topAnchor, left: view.leftAnchor,  right: view.rightAnchor)
        redView.setHeightConstraint(height: 50)
        view.addSubview(menuBar)
        menuBar.anchorToTop(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        menuBar.setHeightConstraint(height: 50);
    }
    func setupCollectionView()
    {
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled = true
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: homeCellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier:subscriptionCellId )
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 10, right: 0)
       // collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 10, right: 0)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.barLeftAnchor?.constant = scrollView.contentOffset.x / 4
    }
    let allTitles = ["Home","Trending","Subscribtions","Account"]
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let currentpage = x / view.frame.width
        jumpToIndex(index: Int(currentpage))
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: allCellIds[indexPath.item], for: indexPath)
            return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left: 0, bottom: 10, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width, height: view.frame.height - 60)
    }
}

