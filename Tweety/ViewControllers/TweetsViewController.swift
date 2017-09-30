//
//  TweetsViewController.swift
//  Tweety
//
//  Created by Varun on 9/29/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    var tweets:[Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterApi.sharedInstance.homeTimeline(sucess: { (tweets) in
            self.tweets = tweets
        }) { (error: Error!) in
            //
        }
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
