//
//  Map.swift
//  balinaSoft
//
//  Created by Vlad Sys on 12/13/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import Foundation

class map : UIViewController{
    
    @IBOutlet weak var navBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
       
        navBtn.target = self.revealViewController();
        navBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}
