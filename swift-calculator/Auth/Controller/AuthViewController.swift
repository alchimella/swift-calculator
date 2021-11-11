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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = "PAGE 1"
    }
    
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

        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
            
            if let token = AccessToken.current, !token.isExpired {
                let calculatorVC = CalculatorViewController.instantiate(fromAppStoryboard: .Calculator)
                self.navigationController?.pushViewController(calculatorVC, animated: true)
            }
        }
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
