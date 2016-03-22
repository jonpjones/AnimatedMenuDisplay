//
//  ViewController.swift
//  SlideOutTest
//
//  Created by Jonathan Jones on 3/21/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var buttonOne: UIButton!
    var buttonDictionary = Dictionary<UIButton, String>()
    var animator = UIDynamicAnimator()
    var sidebarArray = [MenuLabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator.init(referenceView: self.view)
        buttonOne.backgroundColor = UIColor.lightGrayColor()
        buttonOne.setTitle("Tap Me!", forState: UIControlState.Normal)
        buttonOne.layer.cornerRadius = buttonOne.frame.width / 2
        
        
// However many options that we want in our slide out menu, we can create that many buttons.
//        
//        setUpMenuItem("Main Page", segueID: "nil", position: 1)
//        setUpMenuItem("First Page", segueID: "FirstSegueID", position: 2)
//        setUpMenuItem("Second Page", segueID: "SecondSegueID", position: 3)
//        
        
        
    }
    
    func setUpMenuItem (buttonTitle: String, segueID: String, position: CGFloat) -> (MenuLabel) {
        var sidebarLabel = MenuLabel()
        sidebarLabel.text = buttonTitle
        sidebarLabel.textColor = UIColor.whiteColor()
        sidebarLabel.adjustsFontSizeToFitWidth = true
        sidebarLabel.userInteractionEnabled = true
        
        sidebarLabel.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 0.3 * self.view.frame.width, 0.1 * self.view.frame.height)
        
        self.view.addSubview(sidebarLabel)
        self.view.bringSubviewToFront(sidebarLabel)
        
        let leftPoint = CGPointMake(view.frame.origin.x, position * 2 * sidebarLabel.frame.height)
        
        let rightPoint = CGPointMake(sidebarLabel.frame.width, position * 2 * sidebarLabel.frame.height)
        
        let gravity = UIGravityBehavior.init(items: [sidebarLabel])
        let collision = UICollisionBehavior.init(items: [sidebarLabel])
        
        collision.addBoundaryWithIdentifier("bottom", fromPoint: leftPoint, toPoint: rightPoint)
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "sidebarMenuLabelTapped:")
        sidebarLabel.addGestureRecognizer(gestureRecognizer)
        
        sidebarArray.append(sidebarLabel)
        return sidebarLabel
    }
    
    func sidebarMenuLabelTapped (sender: UITapGestureRecognizer) {
        print(sender)
        
    }
    
    @IBAction func menuButtonTapped(sender: AnyObject) {
        bounceOut()
    }
    
    func bounceOut () {
        
        
        let bounceViewImageView = setUpImageView()
        let bounceBGView = setUpBackgroundView()
        
        view.bringSubviewToFront(bounceViewImageView)

//        UIView.animateWithDuration(0.35) { () -> Void in
//            bounceViewImageView.frame = CGRectMake(0.3 * bounceViewImageView.frame.width, 0.15 * bounceViewImageView.frame.height, 0.8 * bounceViewImageView.frame.width, 0.8 * bounceViewImageView.frame.height)
//            self.view.bringSubviewToFront(bounceViewImageView)
//            
//        }
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            
            bounceViewImageView.frame = CGRectMake(0.3 * bounceViewImageView.frame.width, 0.15 * bounceViewImageView.frame.height, 0.8 * bounceViewImageView.frame.width, 0.8 * bounceViewImageView.frame.height)
            self.view.bringSubviewToFront(bounceViewImageView)
            
            }) { (Bool) -> Void in
                
                self.setUpMenuItem("Main Page", segueID: "nil", position: 1)
                self.setUpMenuItem("First Page", segueID: "FirstSegueID", position: 2)
                self.setUpMenuItem("Second Page", segueID: "SecondSegueID", position: 3)
        }
    }
    
    func setUpBackgroundView () -> UIView {
        let bgView = UIView()
        bgView.frame = view.frame
        bgView.backgroundColor = UIColor.grayColor()
        view.addSubview(bgView)
        view.bringSubviewToFront(bgView)
        
        return bgView
    }
    
    func setUpImageView () -> (UIImageView) {
        let imageView = UIImageView()
        imageView.frame = view.frame
        imageView.image = snapshotOfScreen()
        imageView.layer.cornerRadius = 15.0
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        imageView.userInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("returnToScreen"))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        return imageView
    }
    
    func snapshotOfScreen () -> (UIImage) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let bounceViewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        
        return bounceViewImage
    }
    
    func returnToScreen () {
        
        let imageView = view.subviews.last
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            
            imageView!.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.width, self.view.frame.height)
            
            }) { (Bool) -> Void in
                
                imageView?.removeFromSuperview()
                let bgView = self.view.subviews.last
                bgView?.removeFromSuperview()
        }
    }
}

