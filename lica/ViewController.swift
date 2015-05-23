//
//  ViewController.swift
//  lica
//
//  Created by ukn on 5/22/15.
//  Copyright (c) 2015 ukn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var feedScrollView: UIScrollView!
    //@IBOutlet weak var containerView: ContainerView!
    @IBOutlet weak var marginTopContainer: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //feedScrollView.backgroundColor = UIColor.blackColor()
        //marginTopContainer.constant = 380
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}

