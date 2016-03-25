//
//  ThirdViewController.swift
//  SlideOutTest
//
//  Created by Jonathan Jones on 3/22/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var buttonOne: UIButton!
    let soc = SlideOutController()
    let transitionManager = TransitionManager()

    var menuDictionary = Dictionary<String, [AnyObject]>()

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOne.backgroundColor = UIColor.lightGrayColor()
        buttonOne.setTitle("Tap Me!", forState: UIControlState.Normal)
        buttonOne.layer.cornerRadius = buttonOne.frame.width / 2

        menuDictionary = ["Main Page": ["MainViewController", 1],"First Page":["SecondViewController", 2],"Second Page":["", 3]]
    }

    @IBAction func buttonTapped(sender: UIButton) {
        soc.slideOutWithMenu(self, menuItemDictionary: menuDictionary)

    }
    
}
