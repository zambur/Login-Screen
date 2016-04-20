//
//  BaseService.swift
//  
//
//  Created by Zach Ambur on 4/6/16.
//
//

import Foundation
import Firebase

let ref = Firebase(url: "https://login-zambur.firebaseio.com")

var authUser: Firebase {
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    let currentUser = Firebase(url: "\(ref)").childByAppendingPath("users").childByAppendingPath(userID)
    return currentUser!
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
