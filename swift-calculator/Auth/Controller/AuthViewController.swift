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
    
    private let logger = Logger.shared

    let signInConfig = GIDConfiguration.init(clientID: "84117475166-h91t1926toh8e5dt7inivcob42rp7f8d.apps.googleusercontent.com")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = "PAGE 1"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gidLoginButton = GIDSignInButton()
        let fbLoginButton = FBLoginButton()
        
        gidLoginButton.frame.size = CGSize(width: view.frame.width / 2, height: 54)
        fbLoginButton.frame.size = CGSize(width: gidLoginButton.frame.width, height: 44)
        
        gidLoginButton.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 - (fbLoginButton.frame.height / 2))
        fbLoginButton.center = CGPoint(x: view.frame.width / 2, y: (view.frame.height / 2) + (gidLoginButton.frame.height / 2) + 8)
        
        gidLoginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gidSignIn)))
        
        view.addSubview(gidLoginButton)
        view.addSubview(fbLoginButton)

        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in

            self.logger.setLog(type: .trace, message: "FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
            
            if let token = AccessToken.current, !token.isExpired {
                let calculatorVC = CalculatorViewController.instantiate(fromAppStoryboard: .Calculator)
                self.navigationController?.pushViewController(calculatorVC, animated: true)
            }
            
            let fbLoginManager : LoginManager = LoginManager()
            fbLoginManager.logIn(permissions: [.email], viewController: self) { loginResult in
                switch loginResult {
                case .success(let granted, let declined, let token):
                    self.logger.setLog(type: .info, message: "granted: \(granted), declined: \(declined), token: \(token)")
                case .cancelled:
                    self.logger.setLog(type: .warn, message: "Login: cancelled.")
                case .failed(let error):
                    self.logger.setLog(type: .error, message: "Login with error: \(error.localizedDescription)")
                @unknown default:
                    self.logger.setLog(type: .fatal, message: "FB login unexpected error")
                }
            }
        }
    }
    
    @objc func gidSignIn() {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else {
                self.logger.setLog(type: .error, message: "GOOGLE AUTH ERROR: \(error?.localizedDescription ?? "")")
                return
            }

            self.logger.setLog(type: .info, message: "GOOGLE AUTH SUCCESS")
            
            let calculatorVC = CalculatorViewController.instantiate(fromAppStoryboard: .Calculator)
            self.navigationController?.pushViewController(calculatorVC, animated: true)
        }
    }
}
