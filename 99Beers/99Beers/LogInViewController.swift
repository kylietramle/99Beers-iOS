//
//  LogInViewController.swift
//  99Beers
//
//  Created by Kylie Tram Le on 11/14/16.
//  Copyright © 2016 Kylie Tram Le. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = FBSDKLoginButton()
        
        
        view.addSubview(loginButton)
        // frames are obsolete; change to constraints later
        loginButton.frame = CGRect(x: 16, y:50, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        print("Successfully logged in with Facebook")
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if error != nil {
                print("Failed to start graph request", err as Any)
                return
            }
            
            print(result as Any)
        }
    }
    
 
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out of Facebook!")
    }
}
