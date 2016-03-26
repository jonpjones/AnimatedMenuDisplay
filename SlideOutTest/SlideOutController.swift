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
    var storyBoardID = ""
    var position = CGFloat()
    
}

class SlideOutController: NSObject  {
    private let transitionManager = TransitionManager()
    private var slideoutViewController = UIViewController()
    private var sidebarArray = [MenuLabel]()
    private var menuDictionary = Dictionary<String,[AnyObject]>()
    
    func slideOutWithMenu(soViewController: UIViewController, menuItemDictionary: Dictionary<String,[AnyObject]>) {
        
        menuDictionary = menuItemDictionary
        slideoutViewController = soViewController
        bounceOut(soViewController)
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
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("returnToScreen:"))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        return imageView
    }
    
    // MARK: Slide Overlayed Image View to Right, Slide labels into view
    
    private func bounceOut (soViewController: UIViewController) {
        let bounceViewImageView = setUpImageView(soViewController)
        setUpBackgroundView(soViewController)
        
        for key in menuDictionary.keys {
            let labelName = key
            let segueID = menuDictionary[key]![0] as! String
            let position = CGFloat(menuDictionary[key]![1] as! CGFloat)
            
            setUpMenuItem(soViewController,
                buttonTitle: labelName,
                segueID: segueID,
                position: position)
        }
        soViewController.view.bringSubviewToFront(bounceViewImageView)
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            
            for sidebarLabel in self.sidebarArray {
                
                sidebarLabel.frame = CGRectMake(10,
                    0.1 * sidebarLabel.position * soViewController.view.frame.height,
                    0.3 * soViewController.view.frame.width - 20,
                    0.1 * soViewController.view.frame.height)
            }
            
            bounceViewImageView.frame = CGRectMake(0.3 * bounceViewImageView.frame.width,
                0.15 * bounceViewImageView.frame.height,
                0.8 * bounceViewImageView.frame.width,
                0.8 * bounceViewImageView.frame.height)
            
            soViewController.view.bringSubviewToFront(bounceViewImageView)
        })
    }
    
    private func snapshotOfScreen (soViewController: UIViewController) -> (UIImage) {
        
        UIGraphicsBeginImageContext(soViewController.view.frame.size)
        
        soViewController.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let bounceViewImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return bounceViewImage
    }
    
    private func setUpMenuItem (soViewController: UIViewController, buttonTitle: String, segueID: String, position: CGFloat) -> (MenuLabel) {
        let sidebarLabel = MenuLabel()
        sidebarLabel.text = buttonTitle
        sidebarLabel.textColor = UIColor.whiteColor()
        sidebarLabel.adjustsFontSizeToFitWidth = true
        sidebarLabel.userInteractionEnabled = true
        
        sidebarLabel.frame = CGRectMake(-0.3 * soViewController.view.frame.width,
            0.1 * position * soViewController.view.frame.height,
            0.3 * soViewController.view.frame.width,
            0.1 * soViewController.view.frame.height)
        
        sidebarLabel.storyBoardID = segueID
        sidebarLabel.position = position
        
        soViewController.view.addSubview(sidebarLabel)
        soViewController.view.bringSubviewToFront(sidebarLabel)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "sidebarMenuLabelTapped:")
        sidebarLabel.addGestureRecognizer(gestureRecognizer)
        
        sidebarArray.append(sidebarLabel)
        return sidebarLabel
    }
    
    func sidebarMenuLabelTapped(sender: UITapGestureRecognizer) {
        
        let label = sender.view as! MenuLabel
        
        if label.storyBoardID == "" {
            
            returnToScreen(slideoutViewController)
            
        } else {
            
            returnToScreen(slideoutViewController)
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let destinationViewController = storyBoard.instantiateViewControllerWithIdentifier(label.storyBoardID)
            destinationViewController.transitioningDelegate = self.transitionManager
            
            slideoutViewController.presentViewController(destinationViewController,
                animated: true,
                completion: nil)
        }
    }
    
    func returnToScreen (soViewController: UIViewController) {
        
        let imageView = slideoutViewController.view.subviews.last
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            
            for label in self.sidebarArray {
                label.center = CGPointMake(-label.frame.width, label.frame.midY)
            }
            
            imageView!.frame = CGRectMake(self.slideoutViewController.view.frame.origin.x,
                self.slideoutViewController.view.frame.origin.y,
                self.slideoutViewController.view.frame.width,
                self.slideoutViewController.view.frame.height)
            
            }) { (Bool) -> Void in
                
                imageView!.removeFromSuperview()
                
                for label in self.sidebarArray {
                    label.removeFromSuperview()
                }
                
                self.sidebarArray.removeAll()
                self.menuDictionary.removeAll()
                
                let bgView = self.slideoutViewController.view.subviews.last
                bgView?.removeFromSuperview()
        }
    }
}

