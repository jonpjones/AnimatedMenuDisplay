//
//  SlideOutController.swift
//  SlideOutTest
//
//  Created by Jonathan Jones on 3/23/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import Foundation
import UIKit

class MenuLabel: UILabel {
    var segueID = ""
}

private var sidebarArray = [MenuLabel]()
private var menuDictionary = Dictionary<String,String>()

func menuLabelTitles (menuItemDictionary: Dictionary<String,String>) {
    menuDictionary = menuItemDictionary
}


// MARK: Setting Up Background and Image View

private func setUpBackgroundView (soViewController: UIViewController) -> UIView {
    let bgView = UIView()
    bgView.frame = soViewController.view.frame
    bgView.backgroundColor = UIColor.grayColor()
    soViewController.view.addSubview(bgView)
    soViewController.view.bringSubviewToFront(bgView)
    
    return bgView
}

private func setUpImageView (soViewController: UIViewController) -> (UIImageView) {
    let imageView = UIImageView()
    imageView.frame = soViewController.view.frame
    imageView.image = snapshotOfScreen(soViewController)
    imageView.layer.cornerRadius = 15.0
    imageView.clipsToBounds = true
    soViewController.view.addSubview(imageView)
    
    imageView.userInteractionEnabled = true
    
    let gestureRecognizer = UITapGestureRecognizer(target: soViewController, action: Selector("returnToScreen"))
    imageView.addGestureRecognizer(gestureRecognizer)
    
    return imageView
}

// MARK: Slide Overlayed Image View to Right, Slide labels into view

private func bounceOut (soViewController: UIViewController) {
    
    let bounceViewImageView = setUpImageView(soViewController)
    let bounceBGView = setUpBackgroundView(soViewController)
    
    var x = 1
    for key in menuDictionary.keys {
        let menuLabel = setUpMenuItem(soViewController, buttonTitle: key, segueID: menuDictionary[key]!, position: CGFloat(x))
        sidebarArray.append(menuLabel)
        x = x + 1
    }
    
    soViewController.view.bringSubviewToFront(bounceViewImageView)
    
    UIView.animateWithDuration(0.35, animations: { () -> Void in
        
        bounceViewImageView.frame = CGRectMake(0.3 * bounceViewImageView.frame.width, 0.15 * bounceViewImageView.frame.height, 0.8 * bounceViewImageView.frame.width, 0.8 * bounceViewImageView.frame.height)
        soViewController.view.bringSubviewToFront(bounceViewImageView)
        
        }) { (Bool) -> Void in
            
            
// SHOULD TAKE ARRAY OF DICTIONARIES MAYBE? KEY = LABEL TITLE AND VALUE = SEGUE ID
            
//            self.setUpMenuItem("Main Page", segueID: "", position: 1)
//            self.setUpMenuItem("First Page", segueID: "FirstSegueID", position: 2)
//            self.setUpMenuItem("Second Page", segueID: "SecondSegueID", position: 3)
    }
}



private func snapshotOfScreen (soViewController: UIViewController) -> (UIImage) {
    UIGraphicsBeginImageContext(soViewController.view.frame.size)
    soViewController.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let bounceViewImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    
    return bounceViewImage
}

private func setUpMenuItem (soViewController: UIViewController, buttonTitle: String, segueID: String, position: CGFloat) -> (MenuLabel) {
    var sidebarLabel = MenuLabel()
    sidebarLabel.text = buttonTitle
    sidebarLabel.textColor = UIColor.whiteColor()
    sidebarLabel.adjustsFontSizeToFitWidth = true
    sidebarLabel.userInteractionEnabled = true
    
    sidebarLabel.frame = CGRectMake(-(0.3 * soViewController.view.frame.width), 44 + 0.1 * position * soViewController.view.frame.height, 0.3 * soViewController.view.frame.width, 0.1 * soViewController.view.frame.height)
    
    soViewController.view.addSubview(sidebarLabel)
    soViewController.view.bringSubviewToFront(sidebarLabel)
    
//    UIView.animateWithDuration(0.35, animations: { () -> Void in
//        sidebarLabel.frame = CGRectMake(10, 44 + 0.1 * position * soViewController.view.frame.height, 0.3 * soViewController.view.frame.width, 0.1 * soViewController.view.frame.height)
//        }) { (Bool) -> Void in
//            
//    }
    
    let gestureRecognizer = UITapGestureRecognizer(target: soViewController, action: "sidebarMenuLabelTapped:")
    sidebarLabel.addGestureRecognizer(gestureRecognizer)
    
    sidebarArray.append(sidebarLabel)
    print(sidebarArray.count)
    return sidebarLabel
}

private func sidebarMenuLabelTapped (sender: UITapGestureRecognizer) {
    print(sender)
}


private func returnToScreen (soViewController: UIViewController) {
    let imageView = soViewController.view.subviews[soViewController.view.subviews.count - 1 - sidebarArray.count]
    print(soViewController.view.subviews.count)
    print(soViewController.view.subviews.count - 1 - sidebarArray.count)
    
    UIView.animateWithDuration(0.35, animations: { () -> Void in
        
        for label in sidebarArray {
            label.center = CGPointMake(-label.frame.width, label.frame.midY)
        }
        
        
        imageView.frame = CGRectMake(soViewController.view.frame.origin.x, soViewController.view.frame.origin.y, soViewController.view.frame.width, soViewController.view.frame.height)
        
        
        }) { (Bool) -> Void in
            
            imageView.removeFromSuperview()
            for label in sidebarArray {
                label.removeFromSuperview()
                
            }
            sidebarArray.removeAll()
            
            let bgView = soViewController.view.subviews.last
            bgView?.removeFromSuperview()
            
    }
}

