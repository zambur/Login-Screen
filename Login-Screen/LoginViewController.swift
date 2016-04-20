//
//  LoginViewController.swift
//  Login
//
//  Created by Zach Ambur on 4/6/16.
//  Copyright © 2016 Zach Ambur. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var loginLabelCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var emailTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var emailCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var passwordTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var passwordCenterConstraint: NSLayoutConstraint!
    @IBOutlet var passwordHorizontalConstraint: NSLayoutConstraint!
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var loginLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var loginTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var loginCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet var detailsCenterConstraint: NSLayoutConstraint!
    @IBOutlet var orCenterConstraint: NSLayoutConstraint!
    @IBOutlet var facebookCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet var dontAccountCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet var dropDownAlert: UILabel!
    @IBOutlet var dropDownAlertConstraint: NSLayoutConstraint!
    @IBOutlet var facebookConstraint: NSLayoutConstraint!
    
    @IBOutlet var CAlabelCenterConstraint: NSLayoutConstraint!

    @IBOutlet var CAemailTextField: UITextField!
    @IBOutlet var CAemailLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var CAemailTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var CAemailCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet var CApasswordTextField: UITextField!
    @IBOutlet var CApasswordLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var CApasswordTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var CApasswordCenterConstraint: NSLayoutConstraint!
    @IBOutlet var CApasswordHorizontalConstraint: NSLayoutConstraint!
    
    @IBOutlet var CAcancelButton: UIButton!
    @IBOutlet var CAcancelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var CAcancelCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet var CAsubmitButton: UIButton!
    @IBOutlet var CAsubmitTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var CAsubmitCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet var CAorCenterConstraint: NSLayoutConstraint!
    @IBOutlet var CAfacebookCenterConstraint: NSLayoutConstraint!
    @IBOutlet var CAfacebookBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var alreadyAccountCenterConstraint: NSLayoutConstraint!
    
    let gradientLayer = CAGradientLayer()
    var keyBoardShowing = false
    var createAccountPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradiante()
        hideKeyboardWhenTappedAround()
        
        CAlabelCenterConstraint.constant += view.bounds.width
        
        CAemailLeadingConstraint.constant += view.bounds.width
        CAemailTrailingConstraint.constant -= view.bounds.width
        CAemailCenterConstraint.active = false
        CAemailTextField.delegate = self
        CAemailTextField.layer.cornerRadius = CGFloat(5.0)
        let CAemailPaddingView = UIView(frame: CGRectMake(0, 0, 20, CAemailTextField.frame.height))
        CAemailTextField.leftView = CAemailPaddingView
        CAemailTextField.leftViewMode = UITextFieldViewMode.Always
        
        CApasswordLeadingConstraint.constant += view.bounds.width
        CApasswordTrailingConstraint.constant -= view.bounds.width
        CApasswordCenterConstraint.active = false
        CApasswordTextField.delegate = self
        CApasswordTextField.layer.cornerRadius = CGFloat(5.0)
        let CApasswordPaddingView = UIView(frame: CGRectMake(0, 0, 20, CApasswordTextField.frame.height))
        CApasswordTextField.leftView = CApasswordPaddingView
        CApasswordTextField.leftViewMode = UITextFieldViewMode.Always
        
        CAcancelLeadingConstraint.constant += view.bounds.width
        CAcancelCenterConstraint.active = false
        CAcancelButton.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2).CGColor
        CAcancelButton.layer.borderWidth = CGFloat(1.75)
        CAcancelButton.layer.cornerRadius = CGFloat(5.0)
        
        CAsubmitTrailingConstraint.constant -= view.bounds.width
        CAsubmitCenterConstraint.active = false
        CAsubmitButton.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2).CGColor
        CAsubmitButton.layer.borderWidth = CGFloat(1.75)
        CAsubmitButton.layer.cornerRadius = CGFloat(5.0)
        
        CAorCenterConstraint.constant += view.bounds.width
        CAfacebookCenterConstraint.constant += view.bounds.width
        
        alreadyAccountCenterConstraint.constant += view.bounds.width
        
        emailTextField.delegate = self
        emailTextField.layer.cornerRadius = CGFloat(5.0)
        let emailPaddingView = UIView(frame: CGRectMake(0, 0, 20, emailTextField.frame.height))
        emailTextField.leftView = emailPaddingView
        emailTextField.leftViewMode = UITextFieldViewMode.Always
        
        passwordTextField.delegate = self
        passwordTextField.layer.cornerRadius = CGFloat(5.0)
        let passwordPaddingView = UIView(frame: CGRectMake(0, 0, 20, passwordTextField.frame.height))
        passwordTextField.leftView = passwordPaddingView
        passwordTextField.leftViewMode = UITextFieldViewMode.Always
        
        loginButton.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2).CGColor
        loginButton.layer.borderWidth = CGFloat(1.75)
        loginButton.layer.cornerRadius = CGFloat(5.0)
        
        dropDownAlertConstraint.constant = -60
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SCLAlertView.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SCLAlertView.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(UIKeyboardWillShowNotification)
        NSNotificationCenter.defaultCenter().removeObserver(UIKeyboardWillHideNotification)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        keyBoardShowing = true
        if createAccountPage == false {
            if passwordHorizontalConstraint.constant == -20 {
                if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                    UIView.animateWithDuration(0.75, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
                        self.passwordHorizontalConstraint.constant -= 60
                        self.facebookConstraint.constant = keyboardSize.height + 20
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
            }
        } else {
            if CApasswordHorizontalConstraint.constant == -20 {
                if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                    UIView.animateWithDuration(0.75, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
                        self.CApasswordHorizontalConstraint.constant -= 60
                        self.CAfacebookBottomConstraint.constant = keyboardSize.height + 20
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        keyBoardShowing = false
        if createAccountPage == false {
            UIView.animateWithDuration(0.75, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
                self.passwordHorizontalConstraint.constant += 60
                self.facebookConstraint.constant = 100
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            UIView.animateWithDuration(0.75, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
                self.CApasswordHorizontalConstraint.constant += 60
                self.CAfacebookBottomConstraint.constant = 100
                self.view.layoutIfNeeded()
            }, completion: nil)
        }

    }
    
    func gradiante() {
        view.backgroundColor = UIColor.clearColor()
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, atIndex: 0)
        var delayTime = 0.0
        for i in 0...12 {
            delay(delayTime) {
                self.gradientLayer.colors = [UIColor.colorArray()[i].CGColor, UIColor.colorArray()[i+1].CGColor, UIColor.colorArray()[i+2].CGColor, UIColor.colorArray()[i+3].CGColor,
                                             UIColor.colorArray()[i+4].CGColor, UIColor.colorArray()[i+5].CGColor, UIColor.colorArray()[i+6].CGColor, UIColor.colorArray()[i+7].CGColor]
            }
            delayTime += 1.0
        }
        gradientLayer.locations = [0.0, 0.14, 0.28, 0.42, 0.56, 0.7, 0.84, 0.98]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            login()
            textField.resignFirstResponder()
        } else if textField == CAemailTextField {
            CApasswordTextField.becomeFirstResponder()
        } else if textField == CApasswordTextField {
            createAccount()
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ref.observeAuthEventWithBlock { (authData) -> Void in
            if authData != nil {
                self.performSegueWithIdentifier("loginSuccessfulSegue", sender: nil)
            }
        }
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        login()
    }
    
    func animateDropDown() {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.dropDownAlert.hidden = false
            self.dropDownAlertConstraint.constant = 0
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) -> Void in
            UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.TransitionNone, animations: {
                self.dropDownAlertConstraint.constant = -60
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) -> Void in
                self.dropDownAlert.hidden = true
            })
        })
    }

    func login() {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        if email != "" && password != "" {
            ref.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                if error != nil {
                    switch (error.code) {
                    case -5:
                        self.dropDownAlert.text = "Invalid Email Address"
                        self.animateDropDown()
                    case -6:
                        self.dropDownAlert.text = "Invalid Password"
                        self.animateDropDown()
                    default:
                        self.dropDownAlert.text = "Error logging in"
                        self.animateDropDown()
                    }
                } else {
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    print("Logged In")
                }
            })
        } else {
            self.dropDownAlert.text = "Invalid Parameters"
            animateDropDown()
        }
    }
    
    @IBAction func facebookLoginAction(sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: nil, handler: {
            (facebookResult, facebookError) -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult.isCancelled {
                print("Facebook login was cancelled.")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                ref.authWithOAuthProvider("facebook", token: accessToken,
                    withCompletionBlock: { error, authData in
                        if error != nil {
                            self.dropDownAlert.text = "Error logging in"
                            self.animateDropDown()
                            print("Facebook login failed. \(error)")
                        } else {
                            print("Logged in with Facebook! \(authData)")
                        }
                })
            }
        })
    }
    
    @IBAction func createAccount(sender: AnyObject) {
        emailTextField.text = ""
        passwordTextField.text = ""
        if keyBoardShowing {
            dismissKeyboard()
        }
        createAccountPage = true
        UIView.animateWithDuration(0.75, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.CAlabelCenterConstraint.constant -= self.view.bounds.width
            self.loginLabelCenterConstraint.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animateWithDuration(0.75, delay: 0.1, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.emailLeadingConstraint.constant -= self.view.bounds.width
            self.emailTrailingConstraint.constant += self.view.bounds.width
            self.emailCenterConstraint.active = false
            
            self.CAemailLeadingConstraint.constant -= self.view.bounds.width
            self.CAemailTrailingConstraint.constant += self.view.bounds.width
            self.CAemailCenterConstraint.active = true
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animateWithDuration(0.75, delay: 0.2, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.passwordLeadingConstraint.constant -= self.view.bounds.width
            self.passwordTrailingConstraint.constant += self.view.bounds.width
            self.passwordCenterConstraint.active = false
            
            self.CApasswordLeadingConstraint.constant -= self.view.bounds.width
            self.CApasswordTrailingConstraint.constant += self.view.bounds.width
            self.CApasswordCenterConstraint.active = true
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animateWithDuration(0.75, delay: 0.4, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.loginLeadingConstraint.constant -= self.view.bounds.width
            self.loginTrailingConstraint.constant += self.view.bounds.width
            self.loginCenterConstraint.active = false
            
            self.CAcancelLeadingConstraint.constant -= self.view.bounds.width
            self.CAcancelCenterConstraint.active = true
            
            self.CAsubmitTrailingConstraint.constant += self.view.bounds.width
            self.CAsubmitCenterConstraint.active = true
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animateWithDuration(0.75, delay: 0.5, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.detailsCenterConstraint.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animateWithDuration(0.75, delay: 0.6, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.orCenterConstraint.constant -= self.view.bounds.width
            self.CAorCenterConstraint.constant -= self.view.bounds.width
            
            self.facebookCenterConstraint.constant -= self.view.bounds.width
            self.CAfacebookCenterConstraint.constant -= self.view.bounds.width
            
            self.dontAccountCenterConstraint.constant -= self.view.bounds.width
            self.alreadyAccountCenterConstraint.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func submitAction(sender: AnyObject) {
        createAccountPage = true
        createAccount()
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        CAemailTextField.text = ""
        CApasswordTextField.text = ""
        if keyBoardShowing {
            dismissKeyboard()
        }
        createAccountPage = false
        UIView.animateWithDuration(0.75, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.CAlabelCenterConstraint.constant += self.view.bounds.width
            self.loginLabelCenterConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animateWithDuration(0.75, delay: 0.1, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.emailLeadingConstraint.constant += self.view.bounds.width
            self.emailTrailingConstraint.constant -= self.view.bounds.width
            self.emailCenterConstraint.active = true
            
            self.CAemailLeadingConstraint.constant += self.view.bounds.width
            self.CAemailTrailingConstraint.constant -= self.view.bounds.width
            self.CAemailCenterConstraint.active = false
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animateWithDuration(0.75, delay: 0.2, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.passwordLeadingConstraint.constant += self.view.bounds.width
            self.passwordTrailingConstraint.constant -= self.view.bounds.width
            self.passwordCenterConstraint.active = true
            
            self.CApasswordLeadingConstraint.constant += self.view.bounds.width
            self.CApasswordTrailingConstraint.constant -= self.view.bounds.width
            self.CApasswordCenterConstraint.active = false
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.75, delay: 0.4, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.loginLeadingConstraint.constant += self.view.bounds.width
            self.loginTrailingConstraint.constant -= self.view.bounds.width
            self.loginCenterConstraint.active = true
            
            self.CAcancelLeadingConstraint.constant += self.view.bounds.width
            self.CAcancelCenterConstraint.active = false
            
            self.CAsubmitTrailingConstraint.constant -= self.view.bounds.width
            self.CAsubmitCenterConstraint.active = false
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.75, delay: 0.5, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.detailsCenterConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.75, delay: 0.6, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.orCenterConstraint.constant += self.view.bounds.width
            self.CAorCenterConstraint.constant += self.view.bounds.width
            
            self.facebookCenterConstraint.constant += self.view.bounds.width
            self.CAfacebookCenterConstraint.constant += self.view.bounds.width
            
            self.dontAccountCenterConstraint.constant += self.view.bounds.width
            self.alreadyAccountCenterConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func createAccount() {
        let email = self.CAemailTextField.text
        let password = self.CApasswordTextField.text
        if email != "" && password != "" {
            ref.createUser(email, password: password, withCompletionBlock: { (error: NSError!) in
                if error == nil {
                    ref.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                        if error == nil {
                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                            print("Account Created")
                            self.performSegueWithIdentifier("loginSuccessfulSegue", sender: nil)
                        } else {
                            print(error.code)
                        }
                    })
                } else {
                    if error.code == -5 {
                        self.dropDownAlert.text = "Invalid Email Address"
                        self.animateDropDown()
                    } else if error.code == -9 {
                        self.dropDownAlert.text = "Email is already taken"
                        self.animateDropDown()
                    }
                    print(error.code)
                }
            })
        } else {
            self.dropDownAlert.text = "Invalid Parameters"
            animateDropDown()
        }
    }
    
    @IBAction func forgotPasswordAction(sender: AnyObject) {
        if keyBoardShowing {
            dismissKeyboard()
        }
        let color = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
        let alertView = SCLAlertView()
        let alertViewIcon = UIImage(named: "Mail.png")
        alertView.addTextField("Email")
        alertView.addButton("Email", target: alertView, selector: #selector(SCLAlertView.checkTextField))
        alertView.showTitle("Reset Password", subTitle: "Enter in your email address", completeText: "Cancel", colorStyle: color, circleIconImage: alertViewIcon)
    }
}