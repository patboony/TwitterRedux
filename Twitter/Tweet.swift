//
//  Tweet.swift
//  Twitter
//
//  Created by Pat Boonyarittipong on 4/26/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var tweetID: String?
    var favorited: Int?
    var retweeted: Int?
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        tweetID = dictionary["id_str"] as? String
        favorited = dictionary["favorite_count"] as? Int
        retweeted = dictionary["retweet_count"] as? Int
        
        // NSDateFormatter is really expensive - maybe use lazy
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
}
