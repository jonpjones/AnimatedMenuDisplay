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
        
    }
    
    func setUpMenuItem (buttonTitle: String, segueID: String, position: CGFloat) -> (MenuLabel) {
        var sidebarLabel = MenuLabel()
        sidebarLabel.text = buttonTitle
        sidebarLabel.textColor = UIColor.whiteColor()
        sidebarLabel.adjustsFontSizeToFitWidth = true
        sidebarLabel.userInteractionEnabled = true
        
        sidebarLabel.frame = CGRectMake(-(0.3 * self.view.frame.width), 44 + 0.1 * position * self.view.frame.height, 0.3 * self.view.frame.width, 0.1 * self.view.frame.height)
        
        self.view.addSubview(sidebarLabel)
        self.view.bringSubviewToFront(sidebarLabel)
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            sidebarLabel.frame = CGRectMake(10, 44 + 0.1 * position * self.view.frame.height, 0.3 * self.view.frame.width, 0.1 * self.view.frame.height)
            }) { (Bool) -> Void in
                
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "sidebarMenuLabelTapped:")
        sidebarLabel.addGestureRecognizer(gestureRecognizer)
        
        sidebarArray.append(sidebarLabel)
        print(sidebarArray.count)
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
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            
            bounceViewImageView.frame = CGRectMake(0.3 * bounceViewImageView.frame.width, 0.15 * bounceViewImageView.frame.height, 0.8 * bounceViewImageView.frame.width, 0.8 * bounceViewImageView.frame.height)
            self.view.bringSubviewToFront(bounceViewImageView)
            
            }) { (Bool) -> Void in
                
                self.setUpMenuItem("Main Page", segueID: "", position: 1)
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
         let imageView = self.view.subviews[self.view.subviews.count - 1 - self.sidebarArray.count]
        print(self.view.subviews.count)
        print(self.view.subviews.count - 1 - self.sidebarArray.count)
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            
            for label in self.sidebarArray {
                label.center = CGPointMake(-label.frame.width, label.frame.midY)
            }
            
           
            imageView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.width, self.view.frame.height)

            
            }) { (Bool) -> Void in
                
                imageView.removeFromSuperview()
                for label in self.sidebarArray {
                    label.removeFromSuperview()
                    
                }
                self.sidebarArray.removeAll()
                
                let bgView = self.view.subviews.last
                bgView?.removeFromSuperview()

        }
    }
}

