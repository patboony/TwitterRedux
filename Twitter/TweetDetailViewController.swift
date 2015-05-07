//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Pat Boonyarittipong on 4/27/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var currentTweet: Tweet?
    var tweetID: String?
    var favoriteCount: Int?
    var retweetCount: Int?
    var isFavorited: Bool = false
    var isRetweeted: Bool = false

    @IBAction func retweetAction(sender: AnyObject) {
        TwitterClient.sharedInstance.retweetStatusWithID(tweetID!) {
            (error: NSError?) in
            if error == nil {
                // change text
                self.retweetButton.titleLabel!.text = "Undo"
                self.retweetButton.sizeToFit()
                self.retweetCount! += 1
                self.retweetCountLabel.text = String(format: "%d", self.retweetCount!)
                self.isRetweeted = true
            } else {
                // alert error
            }
        }

    }
    
    @IBAction func favoriteAction(sender: AnyObject) {
        
        if !isFavorited {
            TwitterClient.sharedInstance.favoriteStatusWithParams(["id":tweetID!] as NSDictionary) {
                (error: NSError?) in
                if error == nil {
                    // change text
                    self.favoriteButton.titleLabel!.text = "Unfav"
                    self.favoriteButton.sizeToFit()
                    self.favoriteCount! += 1
                    self.favoriteCountLabel.text = String(format: "%d", self.favoriteCount!)
                    self.isFavorited = true
                } else {
                    // alert error
                }
            }
        } else {
            
            TwitterClient.sharedInstance.unfavoriteStatusWithParams(["id":tweetID!] as NSDictionary) {
                (error: NSError?) in
                if error == nil {
                    // change text color
                    self.favoriteButton.titleLabel!.text = "Favorite"
                    self.favoriteButton.sizeToFit()
                    self.favoriteCount! -= 1
                    self.favoriteCountLabel.text = String(format: "%d", self.favoriteCount!)
                    self.isFavorited = false
                } else {
                    // alert error
                }
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cTweet = currentTweet {
            tweetTextLabel.text = cTweet.text!
            nameLabel.text = cTweet.user!.name!
            screennameLabel.text = "@" + cTweet.user!.screenname!
            timeStampLabel.text = calculateTimePassedSinceTimestamp(cTweet.createdAt)
            favoriteCount = cTweet.favorited!
            retweetCount = cTweet.retweeted
            retweetCountLabel.text = String(format: "%d",retweetCount!)
            favoriteCountLabel.text = String(format: "%d", favoriteCount!)
            tweetID = cTweet.tweetID!
            
            if let profileImageURL = cTweet.user!.profileImageUrl {
                profileImageView.setImageWithURL(NSURL(string: profileImageURL))
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateTimePassedSinceTimestamp(createdAt: NSDate?) -> String {
        
        let diffInSeconds = NSDate().timeIntervalSinceReferenceDate - createdAt!.timeIntervalSinceReferenceDate
        
        if(diffInSeconds >= 3600){
            let hourPassed: Double = floor(diffInSeconds/3600)
            return String(format:"%.0f", hourPassed) + "h"
        } else {
            let minPassed = max(floor(diffInSeconds/60), 1)
            return String(format:"%.0f", minPassed) + "m"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
