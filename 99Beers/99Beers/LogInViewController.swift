//
//  LogInViewController.swift
//  99Beers
//
//  Created by Kylie Tram Le on 11/14/16.
//  Copyright © 2016 Kylie Tram Le. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 255, g: 214, b: 89)
        
        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        // frames are obsolete; change to constraints later
        loginButton.frame = CGRect(x: 16, y:50, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        
    }
    
    // white status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        showEmailAddress()
        
    }
    
    func showEmailAddress () {
        // grab FB's access token string
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {return}
        
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user: ", error ?? "")
                return
            }
            
            print("Successfully loggen in with user: ", user ?? "")
        })
        
        // get user's id, name, email
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil {
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

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}




