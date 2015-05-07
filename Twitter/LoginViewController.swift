//
//  LoginViewController.swift
//  Twitter
//
//  Created by Pat Boonyarittipong on 4/24/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func loginAction(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User?, error: NSError?) in
            
            // Can we put this in the User class? Why would we want to hide this from the View Controller level?
            if user != nil {
                // perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                // handle login error
                self.showAlertWithTitle("Unable to Login", body: "Authorization failed. Please try again.")
                
            }
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
