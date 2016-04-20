import Foundation
import UIKit

// Button sub-class
public class SCLButton: UIButton {
    var target:AnyObject!
    var selector:Selector!
    var action:(()->Void)!
    
    public init() {
        super.init(frame: CGRectZero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override public init(frame:CGRect) {
        super.init(frame:frame)
    }
}

let kCircleHeightBackground: CGFloat = 62.0

// The Main Class
public class SCLAlertView: UIViewController {
    let kDefaultShadowOpacity: CGFloat = 0.7
    let kCircleTopPosition: CGFloat = -12.0
    let kCircleBackgroundTopPosition: CGFloat = -15.0
    let kCircleHeight: CGFloat = 56.0
    let kCircleIconHeight: CGFloat = 30.0
    let kTitleTop:CGFloat = 30.0
    let kTitleHeight:CGFloat = 40.0
    let kWindowWidth: CGFloat = 240.0
    var kWindowHeight: CGFloat = 178.0
    var kTextHeight: CGFloat = 90.0
    let kTextFieldHeight: CGFloat = 45.0
    let kButtonHeight: CGFloat = 45.0
    
    // Font
    let kDefaultFont = "HelveticaNeue"
    let kButtonFont = "HelveticaNeue-Bold"
    
    // UI Colour
    var pressBrightnessFactor = 0.85
    
    // UI Options
    let txt = UITextField()
    public var contentViewCornerRadius : CGFloat = 5.0
    public var fieldCornerRadius : CGFloat = 3.0
    public var buttonCornerRadius : CGFloat = 3.0
    
    // Actions
    public var hideWhenBackgroundViewIsTapped = false
    
    // Members declaration
    var baseView = UIView()
    var labelTitle = UILabel()
    var viewText = UITextView()
    var contentView = UIView()
    var circleBG = UIView(frame:CGRect(x:0, y:0, width:kCircleHeightBackground, height:kCircleHeightBackground))
    var circleView = UIView()
    var circleIconView : UIView?
    private var inputs = [UITextField]()
    internal var buttons = [SCLButton]()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    required public init() {
        super.init(nibName:nil, bundle:nil)
        // Set up main view
        view.frame = UIScreen.mainScreen().bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:kDefaultShadowOpacity)
        view.addSubview(baseView)
        // Base View
        baseView.frame = view.frame
        baseView.addSubview(contentView)
        // Content View
        contentView.backgroundColor = UIColor(white:1, alpha:1)
        contentView.layer.cornerRadius = contentViewCornerRadius
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.addSubview(labelTitle)
        contentView.addSubview(viewText)
        // Circle View
        circleBG.backgroundColor = UIColor.whiteColor()
        circleBG.layer.cornerRadius = circleBG.frame.size.height / 2
        baseView.addSubview(circleBG)
        circleBG.addSubview(circleView)
        let x = (kCircleHeightBackground - kCircleHeight) / 2
        circleView.frame = CGRect(x:x, y:x, width:kCircleHeight, height:kCircleHeight)
        circleView.layer.cornerRadius = circleView.frame.size.height / 2
        // Title
        labelTitle.numberOfLines = 1
        labelTitle.textAlignment = .Center
        labelTitle.font = UIFont(name: kDefaultFont, size:20)
        labelTitle.frame = CGRect(x:12, y:kTitleTop, width: kWindowWidth - 24, height:kTitleHeight)
        // View text
        viewText.editable = false
        viewText.textAlignment = .Center
        viewText.textContainerInset = UIEdgeInsetsZero
        viewText.textContainer.lineFragmentPadding = 0;
        viewText.font = UIFont(name: kDefaultFont, size:14)
        // Colours
        contentView.backgroundColor = UIColor.whiteColor()
        labelTitle.textColor = UIColor.darkGrayColor()
        viewText.textColor = UIColor.grayColor()
        contentView.layer.borderColor = UIColor.grayColor().CGColor
        //Gesture Recognizer for tapping outside the textinput
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SCLAlertView.tapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let rv = UIApplication.sharedApplication().keyWindow! as UIWindow
        let sz = rv.frame.size
        
        // Set background frame
        view.frame.size = sz
        
        // computing the right size to use for the textView
        let maxHeight = sz.height - 100 // max overall height
        var consumedHeight = CGFloat(0)
        consumedHeight += kTitleTop + kTitleHeight
        consumedHeight += 14
        consumedHeight += kButtonHeight * CGFloat(buttons.count)
        consumedHeight += kTextFieldHeight * CGFloat(inputs.count)
        let maxViewTextHeight = maxHeight - consumedHeight
        let viewTextWidth = kWindowWidth - 24
        let suggestedViewTextSize = viewText.sizeThatFits(CGSizeMake(viewTextWidth, CGFloat.max))
        let viewTextHeight = min(suggestedViewTextSize.height, maxViewTextHeight)
        
        let windowHeight = consumedHeight + viewTextHeight
        // Set frames
        var x = (sz.width - kWindowWidth) / 2
        var y = (sz.height - windowHeight - (kCircleHeight / 8)) / 2
        contentView.frame = CGRect(x:x, y:y, width:kWindowWidth, height:windowHeight)
        contentView.layer.cornerRadius = contentViewCornerRadius
        y -= kCircleHeightBackground * 0.6
        x = (sz.width - kCircleHeightBackground) / 2
        circleBG.frame = CGRect(x:x, y:y+6, width:kCircleHeightBackground, height:kCircleHeightBackground)
        
        //adjust Title frame based on circularIcon show/hide flag
        let titleOffset : CGFloat = 0.0
        labelTitle.frame = labelTitle.frame.offsetBy(dx: 0, dy: titleOffset)
        
        // Subtitle
        y = kTitleTop + kTitleHeight + titleOffset
        viewText.frame = CGRect(x:12, y:y, width: kWindowWidth - 24, height:kTextHeight)
        viewText.frame = CGRect(x:12, y:y, width: viewTextWidth, height:viewTextHeight)
        // Text fields
        y += viewTextHeight + 14.0
        for txt in inputs {
            txt.frame = CGRect(x:12, y:y, width:kWindowWidth - 24, height:30)
            txt.layer.cornerRadius = fieldCornerRadius
            y += kTextFieldHeight
        }
        // Buttons
        for btn in buttons {
            btn.frame = CGRect(x:12, y:y, width:kWindowWidth - 24, height:35)
            btn.layer.cornerRadius = buttonCornerRadius
            y += kButtonHeight
        }
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SCLAlertView.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SCLAlertView.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    override public func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(UIKeyboardWillShowNotification)
        NSNotificationCenter.defaultCenter().removeObserver(UIKeyboardWillHideNotification)
    }
    
    public func addTextField(title:String?=nil)->UITextField {
        // Update view height
        kWindowHeight += kTextFieldHeight
        // Add text field
        
        txt.borderStyle = UITextBorderStyle.RoundedRect
        txt.font = UIFont(name:kDefaultFont, size: 14)
        txt.autocapitalizationType = UITextAutocapitalizationType.None
        txt.autocorrectionType = UITextAutocorrectionType.No
        txt.spellCheckingType = UITextSpellCheckingType.No
        txt.keyboardType = UIKeyboardType.EmailAddress
        txt.clearButtonMode = UITextFieldViewMode.WhileEditing
        txt.returnKeyType = UIReturnKeyType.Done
        txt.layer.masksToBounds = true
        txt.layer.borderWidth = 1.0
        if title != nil {
            txt.placeholder = title!
        }
        contentView.addSubview(txt)
        inputs.append(txt)
        return txt
    }
    
    public func addButton(title:String, target:AnyObject, selector:Selector)->SCLButton {
        // Update view height
        kWindowHeight += kButtonHeight
        // Add button
        let btn = SCLButton()
        btn.layer.masksToBounds = true
        btn.setTitle(title, forState: .Normal)
        btn.titleLabel?.font = UIFont(name:kButtonFont, size: 14)
        contentView.addSubview(btn)
        buttons.append(btn)
        btn.target = target
        btn.selector = selector
        btn.addTarget(self, action:#selector(SCLAlertView.buttonTapped(_:)), forControlEvents:.TouchUpInside)
        return btn
    }
    
    func buttonTapped(btn:SCLButton) {
        let ctrl = UIControl()
        ctrl.sendAction(btn.selector, to:btn.target, forEvent:nil)
    }
    
    var tmpContentViewFrameOrigin: CGPoint?
    var tmpCircleViewFrameOrigin: CGPoint?
    
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let beginKeyBoardFrame = userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.origin.y else {return}
        guard let endKeyBoardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.origin.y else {return}
        
        tmpContentViewFrameOrigin = self.contentView.frame.origin
        tmpCircleViewFrameOrigin = self.circleBG.frame.origin
        let newContentViewFrameY = beginKeyBoardFrame - endKeyBoardFrame - self.contentView.frame.origin.y
        let newBallViewFrameY = self.circleBG.frame.origin.y - newContentViewFrameY
        self.contentView.frame.origin.y -= newContentViewFrameY
        self.circleBG.frame.origin.y = newBallViewFrameY
    }
    
    func keyboardWillHide(notification: NSNotification) {
            if(self.tmpContentViewFrameOrigin != nil){
                self.contentView.frame.origin.y = self.tmpContentViewFrameOrigin!.y
            }
            if(self.tmpCircleViewFrameOrigin != nil){
                self.circleBG.frame.origin.y = self.tmpCircleViewFrameOrigin!.y
            }
    }
    
    //Dismiss keyboard when tapped outside textfield
    func tapped(gestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
        if let tappedView = gestureRecognizer.view where tappedView.hitTest(gestureRecognizer.locationInView(tappedView), withEvent: nil) == baseView && hideWhenBackgroundViewIsTapped {
            hideView()
        }
    }
    
    // showTitle(view, title, subTitle, duration, style)
    public func showTitle(title: String, subTitle: String, completeText: String?, colorStyle: UIColor, circleIconImage: UIImage? = nil) -> SCLAlertView {
        let rv = UIApplication.sharedApplication().keyWindow! as UIWindow
        rv.addSubview(view)
        view.frame = rv.bounds
        baseView.frame = rv.bounds
        
        // Title
        if !title.isEmpty {
            self.labelTitle.text = title
        }
        
        // Subtitle
        if !subTitle.isEmpty {
            viewText.text = subTitle
            // Adjust text view size, if necessary
            let str = subTitle as NSString
            let attr = [NSFontAttributeName:viewText.font ?? UIFont()]
            let sz = CGSize(width: kWindowWidth - 24, height:90)
            let r = str.boundingRectWithSize(sz, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:attr, context:nil)
            let ht = ceil(r.size.height)
            if ht < kTextHeight {
                kWindowHeight -= (kTextHeight - ht)
                kTextHeight = ht
            }
        }
        
        // Done button
        addButton(completeText!, target:self, selector:#selector(SCLAlertView.hideView))
        
        // Alert view colour and images
        circleView.backgroundColor = colorStyle
        // icon
        circleIconView = UIImageView(image: circleIconImage!)

        circleView.addSubview(circleIconView!)
        let x = (kCircleHeight - kCircleIconHeight) / 2
        circleIconView!.frame = CGRectMake( x, x, kCircleIconHeight, kCircleIconHeight)
        
        for txt in inputs {
            txt.layer.borderColor = colorStyle.CGColor
        }
        for btn in buttons {
            btn.backgroundColor = colorStyle
            btn.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
        }
        
        // Animate in the alert view
        self.baseView.frame.origin.y = -400
        UIView.animateWithDuration(0.2, animations: {
            self.baseView.center.y = rv.center.y + 15
            self.view.alpha = 1
            }, completion: { finished in
                UIView.animateWithDuration(0.2, animations: {
                    self.baseView.center = rv.center
                })
        })
        return self
    }
    
    public func checkTextField() {
        if txt.text! != "" {
            ref.resetPasswordForUser(txt.text!, withCompletionBlock: { error in })
            hideView()
        }
    }
    
    // Close SCLAlertView
    public func hideView() {
        UIView.animateWithDuration(0.2, animations: {
            self.view.alpha = 0
            }, completion: { finished in
                self.view.removeFromSuperview()
        })
    }
}
