//
//  DefaultViewController.swift
//  99Beers
//
//  Created by Kylie Tram Le on 11/15/16.
//  Copyright © 2016 Kylie Tram Le. All rights reserved.
//

import UIKit
import Firebase

class DefaultViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 255/255, green: 214/255, blue: 89/255, alpha: 1)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    func handleLogout() {
        let loginController = LogInViewController()
        present(loginController, animated: true, completion: nil)
    }
}
