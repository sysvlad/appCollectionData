//
//  DetailViewController.swift
//  balinaSoft
//
//  Created by Vlad Sys on 12/25/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var image = UIImage()
    var name = " "
    override func viewDidLoad() {
        super.viewDidLoad()

        imgImage.image = image
        lblName.text! = name
    
    }

  


}
