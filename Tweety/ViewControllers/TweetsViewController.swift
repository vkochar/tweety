//
//  TweetsViewController.swift
//  Tweety
//
//  Created by Varun on 9/29/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit
import MBProgressHUD

class TweetsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var tweets:[Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: "TweetCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "tweetCell")
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        MBProgressHUD.showAdded(to: view, animated: true)
        loadTweets()
    }
    
    private func loadTweets() {
        TwitterApi.sharedInstance.homeTimeline(sucess: { (tweets) in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            MBProgressHUD.hide(for: self.view, animated: true)
        }) { (error: Error!) in
            //
        }
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        loadTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterApi.sharedInstance.logout()
        NotificationCenter.default.post(name: logoutNotification, object: nil)
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

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        cell.tweet = tweet
        return cell
    }
    
}
