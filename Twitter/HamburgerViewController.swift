//
//  HamburgerViewController.swift
//  Twitter
//
//  Created by Pat Boonyarittipong on 5/6/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController, ApplyMenuDelegate {
    
    var mainVC: UINavigationController!
    var menuVC: UINavigationController!
    
    @IBOutlet weak var containerView: UIView!
    
    var originalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        loadTimeLineInMainVC()
        
        menuVC = storyboard.instantiateViewControllerWithIdentifier("NavigationControllerMenu") as! UINavigationController
        menuVC.view.frame = CGRect(origin: CGPointZero, size: CGSize(width: 320, height: containerView.frame.height))
        containerView.insertSubview(menuVC.view, belowSubview: mainVC.view)
        
        let menuVisibleVC = menuVC.visibleViewController as! MenuViewController
        menuVisibleVC.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTimeLineInMainVC(){
        if mainVC != nil {
            mainVC.willMoveToParentViewController(nil)
            mainVC.view.removeFromSuperview()
            mainVC.removeFromParentViewController()
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        mainVC = storyboard.instantiateViewControllerWithIdentifier("NavigationControllerTimeline") as! UINavigationController
        addChildViewController(mainVC)
        mainVC.view.frame = containerView.frame
        containerView.addSubview(mainVC.view)
        originalCenter = mainVC.visibleViewController.view.center
        //println(originalCenter)
    }
    
    func loadProfileInMainVCWithScreenname(screenname: String){
        if mainVC != nil {
            mainVC.willMoveToParentViewController(nil)
            mainVC.view.removeFromSuperview()
            mainVC.removeFromParentViewController()
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        mainVC = storyboard.instantiateViewControllerWithIdentifier("NavigationControllerProfile") as! UINavigationController
        addChildViewController(mainVC)
        mainVC.view.frame = containerView.frame
        
        let profileVC = mainVC.visibleViewController as! ProfileViewController
        profileVC.usernameToLoadProfile = screenname
        
        containerView.insertSubview(mainVC.view, aboveSubview: menuVC.view)
        originalCenter = mainVC.visibleViewController.view.center
    }
    
    @IBAction func swipeAction(sender: UIPanGestureRecognizer) {
        
        let velocity = sender.velocityInView(self.view)
        let translation = sender.translationInView(self.view)
        
        if sender.state == .Began {
            
            
            
            
        } else if sender.state == .Changed {
            if mainVC.view.frame.origin.x
                + translation.x >= 0 {
                mainVC.view.center = CGPoint(x: mainVC.view.center.x + translation.x, y: mainVC.view.center.y)
            }
            sender.setTranslation(CGPointZero, inView: self.view)
            
        } else if sender.state == .Ended {
            if velocity.x > 0 {
                showHamburgerMenu()
            } else {
                hideHamburgerMenu()
            }
        }
    }
    
    func showHamburgerMenu(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.mainVC.view.center = CGPoint(x: 500, y: self.originalCenter.y)
            
            }, completion: { (Bool) -> Void in
                // Remove stuff
        })
    }
    
    func hideHamburgerMenu(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.mainVC.view.center = self.originalCenter
            
            }, completion: { (Bool) -> Void in
                // Remove stuff
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
    
    func ApplyMenu(menuViewController: MenuViewController, menuValue value: Int){
        if value == 0 {
            hideHamburgerMenu()
            // Hope this doesn't crash
            delay(0.3, closure: {
                self.loadProfileInMainVCWithScreenname(User.currentUser!.screenname!)
            })
            
        }
        if value == 1 {
            hideHamburgerMenu()
            delay(0.3, closure: {
                self.loadTimeLineInMainVC()
            })
        }
        if value == 2 {
            hideHamburgerMenu()
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
