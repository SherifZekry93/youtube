//
//  FeedCell.swift
//  youtube
//
//  Created by Sherif  Wagih on 9/8/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//
import UIKit
class FeedCell: BaseCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        
        return cv
    }()
    
    let cellId = "songCellId"
    var songs:[Song]?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let v = VideoLauncher()
        v.showVideoPlayer()
    }
    func fetchData()
    {
        ApiService.shared.fetchSongs(url: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") { (songs) in
            self.songs = songs
            self.collectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SongCell
        if let song = songs?[indexPath.item]
        {
            cell.song = song
        }
        return cell
    }
    override func setupViews() {
        addSubview(collectionView)
        collectionView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        collectionView.register(SongCell.self, forCellWithReuseIdentifier:cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 400)
    }
}
