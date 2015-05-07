//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Pat Boonyarittipong on 4/27/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetTextField: UITextField!
    @IBOutlet weak var charRemaining: UILabel!
    
    var replyToStatusID: String?
    var initialText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = User.currentUser?.name!
        screennameLabel.text = "@" + (User.currentUser?.screenname)!
        if let profileImageURL = User.currentUser?.profileImageUrl {
            profileImageView.setImageWithURL(NSURL(string: profileImageURL))
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlertWithTitle(title: String?, body: String){
        let alert = UIAlertController(title: title!, message: body, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(alertAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func tweetAction(sender: AnyObject) {
        TwitterClient.sharedInstance.updateStatusWithParams(["status":tweetTextField.text] as NSDictionary){
            (error: NSError?) in
            if error == nil {
                // alert & dismiss view
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                // alert error
                self.showAlertWithTitle("Tweet Failed", body: "Unable to post this Tweet. Please try again.")
            }
        }
    }

    
    @IBAction func onEditingChanged(sender: AnyObject) {
        charRemaining.text = String(format:"%d", 140 - count(tweetTextField.text))
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
