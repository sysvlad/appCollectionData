//
//  LoginVC.swift
//  balinaSoft
//
//  Created by Vlad Sys on 12/9/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var registrationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //btn
        registrationBtn.layer.cornerRadius = 5
        
      
    }
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            self.presentLoggendIn()
        }
    }

    @IBAction func loginIsTapped(_ sender: Any) {
        
        if let userName = userNameInput.text, let pass = passwordInput.text{
            Auth.auth().signIn(withEmail: userName, password: pass, completion: {
                user, error in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                self.presentLoggendIn()
            })
        }
        
      
        
        /*let params = ["username": userNameInput.text!,
                      "password": passwordInput.text!,
                      
        ]
        let apiMethod = "http://api.example.com"
        
        Alamofire.request(apiMethod, method: .post, parameters: params, encoding: JSONEncoding.default).responseString { (response) in
            
            print(response);
            
            let alertController = UIAlertController(title: "Welcome", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            
            
            
            self.present(alertController, animated: true, completion: nil)
            
        } */
        
    }
    func presentLoggendIn(){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SWRevealViewController: SWRevealViewController = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        self.present(SWRevealViewController, animated: true, completion: nil)
        
    }

}
