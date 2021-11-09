//
//  ViewController.swift
//  swift-calculator
//
//  Created by Abi  Radzhabova on 4/11/21.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class AuthViewController: UIViewController {

    let signInConfig = GIDConfiguration.init(clientID: "84117475166-h91t1926toh8e5dt7inivcob42rp7f8d.apps.googleusercontent.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gidLoginButton = GIDSignInButton()
        let fbLoginButton = FBLoginButton()
        
        gidLoginButton.bounds.size = CGSize(width: view.bounds.width / 2, height: 44)
        fbLoginButton.bounds.size = CGSize(width: view.bounds.width / 2, height: 44)
        
        gidLoginButton.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2 - fbLoginButton.bounds.height)
        fbLoginButton.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2 + gidLoginButton.bounds.height / 2)
        
        gidLoginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gidSignIn)))
        
        view.addSubview(gidLoginButton)
        view.addSubview(fbLoginButton)

        
    }
    
    @objc func gidSignIn() {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else {
                print("GOOGLE AUTH ERROR", error?.localizedDescription)
                return
            }

            // If sign in succeeded, display the app's main content View.
            print("GOOGLE AUTH SUCCESS")
            
            let calculatorVC = CalculatorViewController.instantiate(fromAppStoryboard: .Calculator)
            self.navigationController?.pushViewController(calculatorVC, animated: true)
        }
    }
}
