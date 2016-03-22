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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOne.backgroundColor = UIColor.lightGrayColor()
        buttonOne.setTitle("Tap Me!", forState: UIControlState.Normal)
        buttonOne.layer.cornerRadius = buttonOne.frame.width / 2
        
    }
    
    @IBAction func menuButtonTapped(sender: AnyObject) {
        bounceOut()
    }
    
    func bounceOut () {
        let bounceViewImageView = setUpImageView()
        let bounceBGView = setUpBackgroundView()
        
        view.bringSubviewToFront(bounceViewImageView)

        UIView.animateWithDuration(0.35) { () -> Void in
            bounceViewImageView.frame = CGRectMake(0.3 * bounceViewImageView.frame.width, 0.15 * bounceViewImageView.frame.height, 0.8 * bounceViewImageView.frame.width, 0.8 * bounceViewImageView.frame.height)
            self.view.bringSubviewToFront(bounceViewImageView)
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

