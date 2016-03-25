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
    var menuDictionary = Dictionary<String, [AnyObject]>()
    let transitionManager = TransitionManager()
    let soc = SlideOutController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOne.backgroundColor = UIColor.lightGrayColor()
        buttonOne.setTitle("Tap Me!", forState: UIControlState.Normal)
        buttonOne.layer.cornerRadius = buttonOne.frame.width / 2
        
        menuDictionary = ["Main Page": ["", 1],"First Page":["FirstSegueID", 2],"Second Page":["SecondSegueID", 3]]
  
    }
    
    @IBAction func menuButtonTapped(sender: AnyObject) {
        soc.slideOutWithMenu(self, menuItemDictionary: menuDictionary)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let toViewController = segue.destinationViewController
        toViewController.transitioningDelegate = self.transitionManager
    }
    
}

