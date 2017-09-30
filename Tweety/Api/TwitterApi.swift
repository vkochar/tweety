//
//  TwitterApi.swift
//  Tweety
//
//  Created by Varun on 9/26/17.
//  Copyright © 2017 Varun. All rights reserved.
//

private let consumerKey = "t2n63JfzYcxJ30yGdrOImk4zQ"
private let consumeerSecret = "IjtIBmV6UTpemTe1TETFwg6Dgw6s34W6YsIRS6SnwSyLTBekpS"

private let baseUrl = "https://api.twitter.com"
private let requestTokenPath = "oauth/request_token"
private let authorizeUrlString = "\(baseUrl)/oauth/authorize"
private let accessTokenPath = "oauth/access_token"

private let userPath = "1.1/account/verify_credentials.json"
private let homeTimelinePath = "1.1/statuses/home_timeline.json"

import Foundation
import BDBOAuth1Manager

class TwitterApi: BDBOAuth1SessionManager {
    
    static let sharedInstance: TwitterApi = TwitterApi(baseURL: URL(string: baseUrl)!, consumerKey: consumerKey, consumerSecret: consumeerSecret)
    
    var loginSuccess: (() -> Void)?
    var loginFailure: ((Error) -> Void)?
    
    func login(success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: requestTokenPath, method: "GET", callbackURL: URL(string: "tweety://oauth")!, scope: nil, success: { (credential: BDBOAuth1Credential?) in
            print("got request token")
            UIApplication.shared.open(URL(string: "\(authorizeUrlString)?oauth_token=\(credential!.token!)")!)
        }, failure: { (error: Error!) in
            self.loginFailure?(error)
        })
    }
    
    func handleOpenUrl(url: URL) {
        
        let requestTokenString = url.query!
        let requestToken = BDBOAuth1Credential(queryString: requestTokenString)
        
        fetchAccessToken(withPath: accessTokenPath, method: "POST", requestToken: requestToken, success: { (credential: BDBOAuth1Credential?) in
            print("got access token")
            
            self.currentAccount(success: { (user) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error) in
                self.loginFailure?(error)
            })
            
        }, failure: { (error: Error!) in
            self.loginFailure?(error)
        })
    }
    
    func currentAccount(success: @escaping (User) -> Void, failure: @escaping (Error) -> Void) {
        get(userPath, parameters: nil, progress: nil, success: { (task, response) in
            let user = User.fromJSON(response: response!)
            print(user.name!)
            success(user)
        }, failure: { (task, error: Error) in
            print(error)
            failure(error)
        })
    }
    
    func homeTimeline(sucess: @escaping ([Tweet]) -> Void, failure: @escaping (Error) -> Void) {
        get(homeTimelinePath, parameters: nil, progress: nil, success: { (task, resposne) in
            let dictionaries = resposne as! [NSDictionary]
            var tweets:[Tweet] = []
            print("got tweets")
            dictionaries.forEach{ dictionary in
                let tweet = Tweet.fromJSON(response: dictionary)
                tweets.append(tweet)
                sucess(tweets)
            }
        }, failure: { (task, error: Error) in
            print(error)
            failure(error)
        })
    }
    
    func logout() {
        deauthorize()
        User.currentUser = nil
    }
}
