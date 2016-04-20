//
//  UserViewController.swift
//  Login
//
//  Created by Zach Ambur on 4/7/16.
//  Copyright © 2016 Zach Ambur. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        ref.unauth()
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        self.performSegueWithIdentifier("logoutSegue", sender: nil)
        print("Logged Out")
    }
}