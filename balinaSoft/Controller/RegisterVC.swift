//
//  RegisterVC.swift
//  balinaSoft
//
//  Created by Vlad Sys on 12/9/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import UIKit
import Alamofire

class RegisterVC: UIViewController {
 
    let showAlertError = UIAlertController(title: "no right", message: "Wrong input", preferredStyle: .alert)
 
    //outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var samePassword: UITextField!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
        //btn borders
       signUpBtn.layer.cornerRadius = 5
    }

    @IBAction func signUpPressed(_ sender: Any) {
       
     
  
        let params = ["username": usernameTxt.text!,
                      "password": password.text!,
                      "samePassword": samePassword.text!
        ]
        let apiMethod = "http://api.example.com"
        
        Alamofire.request(apiMethod, method: .post, parameters: params, encoding: JSONEncoding.default).responseString { (response) in
            
            print(response);
            
            let alertController = UIAlertController(title: "REGISTRATION SUCCESSFUL!", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            
            
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
 
    }
    
    
}
