//
//  TimelineViewController.swift
//  Twitter
//
//  Created by Pat Boonyarittipong on 4/25/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        connectToAPI()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        // Implement 'favorite'
        // Tweet.favorite will invoke a POST method

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        User.currentUser?.logout()
        // How do I make the transition animation?
    }
    
    @IBAction func composeAction(sender: AnyObject) {
    }
    
    func connectToAPI(){
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            if tweets != nil {
                self.tweets = tweets
                for tweet in tweets! {
                    println(tweet.text)
                }
            }
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            
        })
        
    }
    
    func onRefresh() {
        
        connectToAPI()
        // how do we actaully make sure that the connection is successful?
        delay(1, closure: {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweetTextLabel.text = tweets?[indexPath.row].text!
        cell.nameLabel.text = tweets?[indexPath.row].user!.name!
        cell.profileImageView.tag = indexPath.row
        cell.timeStampLabel.text = calculateTimePassedSinceTimestamp(tweets?[indexPath.row].createdAt)
        cell.screennameLabel.text = "@" + (tweets?[indexPath.row].user!.screenname)!
        cell.favoriteCount = (tweets?[indexPath.row].favorited)!
        cell.retweetCount = (tweets?[indexPath.row].retweeted)!
        
        cell.retweetCountLabel.text = String(format: "%d", cell.retweetCount!)
        cell.favoriteCountLabel.text = String(format: "%d", cell.favoriteCount!)
        
        if let profileImageURL = tweets?[indexPath.row].user!.profileImageUrl {
            cell.profileImageView.setImageWithURL(NSURL(string: profileImageURL))

        }
        cell.tweetID = tweets?[indexPath.row].tweetID!
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "tweetDetailPush" {
            var tweetDetailVC = segue.destinationViewController as! TweetDetailViewController
            var indexPath = tableView.indexPathForCell(sender as! UITableViewCell) as NSIndexPath!
            tweetDetailVC.currentTweet = tweets?[indexPath.row]
        }
        
        if segue.identifier == "composeModal" {
            
            let composeNC = segue.destinationViewController as! UINavigationController
            let composeVC = composeNC.visibleViewController as! ComposeViewController
        }
        
        if segue.identifier == "showProfileSegue" {
            
            let profileVC = segue.destinationViewController as! ProfileViewController
            let senderTap = sender as! UITapGestureRecognizer
            let senderImage = senderTap.view as! UIImageView
            if tweets != nil {
                profileVC.usernameToLoadProfile = tweets![senderImage.tag].user!.screenname!
                println(profileVC.usernameToLoadProfile)
                println(senderImage.tag)
            }
        }
        
    }
    

}
