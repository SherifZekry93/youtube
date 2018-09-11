//
//  SubscriptionCell.swift
//  youtube
//
//  Created by Sherif  Wagih on 9/8/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
class SubscriptionCell : FeedCell
{
    override func fetchData() {
        ApiService.shared.fetchSongs(url: "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json") { (songs) in
            self.songs = songs
            self.collectionView.reloadData()
        }
    }
    override func setupViews() {
        super.setupViews()
    }
}
