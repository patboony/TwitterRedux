//
//  MenuViewController.swift
//  Twitter
//
//  Created by Pat Boonyarittipong on 5/6/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit


protocol ApplyMenuDelegate {
    func ApplyMenu(menuViewController: MenuViewController, menuValue value: Int)
}


class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuProfileImage: UIImageView!
    @IBOutlet weak var menuProfileView: UIView!
    @IBOutlet weak var menuTimelineView: UIView!
    @IBOutlet weak var menuTimelineMention: UIView!
    @IBOutlet weak var menuProfileNameLabel: UILabel!
    
    var delegate:ApplyMenuDelegate?
    
    var parent: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let profileImageURL = User.currentUser?.profileImageUrl {
            menuProfileImage.setImageWithURL(NSURL(string: profileImageURL))
        }
        
        if let username = User.currentUser?.name {
            menuProfileNameLabel.text = username
            menuProfileNameLabel.sizeToFit()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func menuProfileTapAction(sender: UITapGestureRecognizer) {
        delegate?.ApplyMenu(self, menuValue: 0)
    
    }
    @IBAction func menuTimelineTapAction(sender: UITapGestureRecognizer) {
        delegate?.ApplyMenu(self, menuValue: 1)
    }

    @IBAction func menuMentionTapAction(sender: UITapGestureRecognizer) {
        delegate?.ApplyMenu(self, menuValue: 2)
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
