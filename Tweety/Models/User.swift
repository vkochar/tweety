//
//  User.swift
//  Tweety
//
//  Created by Varun on 9/28/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import Foundation

class User: Codable {
    
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    
    enum CodinKeys: String, CodingKey {
        case name
        case screenname = "screen_name"
        case profileUrl = "profile_image_url_https"
        case tagline = "description"
    }
    
    class func fromJSON(response: Any)-> User {
        let json = try! JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions(rawValue: 0))
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z y"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let user = try! decoder.decode(User.self, from: json)
        return user
    }
}

