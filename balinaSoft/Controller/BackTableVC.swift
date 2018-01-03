//
//  BackTableVC.swift
//  balinaSoft
//
//  Created by Vlad Sys on 12/13/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import Foundation
import FirebaseAuth

class BlackTableVC: UITableViewController{
    @IBAction func signOut(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }catch{
            print("something wront")
        }
    }
    
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Photos","Map"]
        self.tableView.separatorStyle = .none
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        return cell
        
    }
}
