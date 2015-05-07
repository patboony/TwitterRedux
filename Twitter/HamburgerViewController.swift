//
//  HamburgerViewController.swift
//  Twitter
//
//  Created by Pat Boonyarittipong on 5/6/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    var mainVC: UINavigationController!
    var menuVC: UINavigationController!
    
    @IBOutlet weak var containerView: UIView!
    
    var originalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        menuVC = storyboard.instantiateViewControllerWithIdentifier("NavigationControllerMenu") as! UINavigationController
        mainVC = storyboard.instantiateViewControllerWithIdentifier("NavigationControllerTimeline") as! UINavigationController
        mainVC.view.frame = containerView.frame
        containerView.addSubview(mainVC.view)
        
        originalCenter = mainVC.visibleViewController.view.center
        println(originalCenter)
        
        menuVC.view.frame = CGRect(origin: CGPointZero, size: CGSize(width: 0, height: containerView.frame.height))
        containerView.insertSubview(menuVC.view, belowSubview: mainVC.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swipeAction(sender: UIPanGestureRecognizer) {
        
        let velocity = sender.velocityInView(self.view)
        let translation = sender.translationInView(self.view)
        
        if sender.state == .Began {
            
            
            
            
        } else if sender.state == .Changed {
            if mainVC.view.frame.origin.x
                + translation.x >= 0 {
                mainVC.view.center = CGPoint(x: mainVC.view.center.x + translation.x, y: mainVC.view.center.y)
                // Is there another way to do this?
                menuVC.view.frame = CGRect(origin: CGPointZero, size: CGSize(width: menuVC.view.frame.width + translation.x, height: containerView.frame.height))
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
            self.menuVC.view.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.mainVC.view.frame.origin.x, height: self.containerView.frame.height))
            
            }, completion: { (Bool) -> Void in
                // Remove stuff
        })
    }
    
    func hideHamburgerMenu(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.mainVC.view.center = self.originalCenter
            self.menuVC.view.frame = CGRect(origin: CGPointZero, size: CGSize(width: 0, height: self.containerView.frame.height))
            
            }, completion: { (Bool) -> Void in
                // Remove stuff
        })
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
