//
//  LoginVC.swift
//  balinaSoft
//
//  Created by Vlad Sys on 12/9/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var registrationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //btn
        registrationBtn.layer.cornerRadius = 5
        
      
    }

    @IBAction func loginIsTapped(_ sender: Any) {
        
        let params = ["username": userNameInput.text!,
                      "password": passwordInput.text!,
                      
        ]
        let apiMethod = "http://api.example.com"
        
        Alamofire.request(apiMethod, method: .post, parameters: params, encoding: JSONEncoding.default).responseString { (response) in
            
            print(response);
            
            let alertController = UIAlertController(title: "Welcome", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            
            
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    

}
