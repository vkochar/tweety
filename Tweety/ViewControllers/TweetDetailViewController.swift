//
//  TweetDetailViewController.swift
//  Tweety
//
//  Created by Varun on 10/1/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var numberOfRetweetsLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tweet"
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        favoriteButton.setImage(#imageLiteral(resourceName: "favorite"), for: UIControlState.normal)
        favoriteButton.setImage(#imageLiteral(resourceName: "favorite_selected"), for: UIControlState.selected)
        
        showDetails()
    }
    
    private func showDetails() {
        if let tweetUser = tweet.user {
            if let profileImageUrl = tweetUser.profileUrl {
                profileImageView.setImageWith(profileImageUrl)
            }
            if let name = tweetUser.name {
                nameLabel.text = name
            }
            if let handle = tweetUser.screenname {
                handleLabel.text = handle
            }
        }
        
        tweetLabel.text = tweet.text
        
        let favorites = tweet.favoritesCount == nil ? 0 : tweet.favoritesCount!
        numberOfLikesLabel.text = String(describing: favorites)
        
        let retweets = tweet.retweetCount == nil ? 0 : tweet.retweetCount!
        numberOfRetweetsLabel.text = String(describing: retweets)
        
        favoriteButton.isSelected = tweet.isFavorite
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy, hh:mm a"
        
        createdAtLabel.text = dateFormatter.string(from: tweet.timestamp!)
    }
    
    @IBAction func onReply(_ sender: Any) {
    }

    @IBAction func onRetweet(_ sender: Any) {
    }
    
    @IBAction func onFavorite(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
