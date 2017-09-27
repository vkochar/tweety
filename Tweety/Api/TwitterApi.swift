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

import Foundation
import BDBOAuth1Manager

class TwitterApi {
    
    class func login() {
        
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: baseUrl)!, consumerKey: consumerKey, consumerSecret: consumeerSecret)

        twitterClient?.fetchRequestToken(withPath: requestTokenPath, method: "GET", callbackURL: URL(string: "tweety://oauth")!, scope: nil, success: { (credential: BDBOAuth1Credential?) in
            print("got token")
            
            UIApplication.shared.open(URL(string: "\(authorizeUrlString)?oauth_token=\(credential!.token!)")!)
            
        }, failure: { (error: Error?) in
            //
        })
    }
    
    
    class func getAuthToken(requestTokenString: String) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: baseUrl)!, consumerKey: consumerKey, consumerSecret: consumeerSecret)!
        
        let requestToken = BDBOAuth1Credential(queryString: requestTokenString)
        
        twitterClient.fetchAccessToken(withPath: accessTokenPath, method: "POST", requestToken: requestToken, success: { (credential: BDBOAuth1Credential?) in
            print(credential?.token)
            
            twitterClient.get(userPath, parameters: nil, progress: nil, success: { (task, response) in
                print(response)
            }, failure: { (task, error: Error) in
                print(error)
            })
            
        }, failure: { (error: Error?) in
            //
        })
    }
    
}
