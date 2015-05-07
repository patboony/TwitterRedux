//
//  TweetCell.swift
//  Twitter
//
//  Created by Pat Boonyarittipong on 4/27/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweetID: String?
    var favoriteCount: Int?
    var retweetCount: Int?
    var isFavorited: Bool = false
    var isRetweeted: Bool = false
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
    
    
    @IBAction func replyAction(sender: AnyObject) {
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.width
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.width
        screennameLabel.preferredMaxLayoutWidth = screennameLabel.frame.width
    }

}
