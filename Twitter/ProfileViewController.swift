//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Pat Boonyarittipong on 5/6/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var profileBackgroundImageView: UIImageView!
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var tweetTableView: UITableView!
    
    var usernameToLoadProfile: String! = "patboony"
    var userProfile: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // How to make sure this is not nil?
        
    }
    
    override func viewWillAppear(animated: Bool) {
        TwitterClient.sharedInstance.getUserInfoWithParams(["screen_name":usernameToLoadProfile] as NSDictionary) { (user, error) -> () in
            if user != nil {
                self.userProfile = user!
                self.updateProfilePage()
            } else {
                println(error)
            }
        }
    }
    
    func updateProfilePage(){
        
        if userProfile != nil {
            profileImageView.setImageWithURL(NSURL(string: userProfile.profileImageUrl!))
            profileBackgroundImageView.setImageWithURL(NSURL(string: userProfile.profileBackgroundImageUrl!))
            nameLabel.text = userProfile.name!
            screennameLabel.text = "@" + userProfile.screenname!
            tweetsCountLabel.text = String(userProfile.tweetsCount!)
            followingCountLabel.text = String(userProfile.followingCount!)
            followersCountLabel.text = String(userProfile.followersCount!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
