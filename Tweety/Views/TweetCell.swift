//
//  TweetCell.swift
//  Tweety
//
//  Created by Varun on 9/30/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetedByLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timeSinceTweetLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            
            if let profileUrl = tweet.user?.profileUrl {
                profileImage.setImageWith(profileUrl)
            }
            
            if let handle = tweet.user?.screenname {
                handleLabel.text = "@\(handle)"
            }
            
            nameLabel.text = tweet.user?.name
            statusLabel.text = tweet?.text
            
            timeSinceTweetLabel.text = Date().getTimeDifference(pastDate: tweet.timestamp)
            
            favoriteButton.isSelected = tweet.isFavorite
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = 4
        profileImage.clipsToBounds = true
        
        favoriteButton.setImage(#imageLiteral(resourceName: "favorite"), for: UIControlState.normal)
        favoriteButton.setImage(#imageLiteral(resourceName: "favorite_selected"), for: UIControlState.selected)
        retweetButton.setImage(#imageLiteral(resourceName: "retweet"), for: UIControlState.normal)
        retweetButton.setImage(#imageLiteral(resourceName: "retweet_selected"), for: UIControlState.selected)
    }
    
    @IBAction func onReplyButton(_ sender: UIButton) {
    }
    
    @IBAction func onRetweetButton(_ sender: UIButton) {
    }
    
    @IBAction func onFavoriteButton(_ sender: UIButton) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
