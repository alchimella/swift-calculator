//
//  BaseNavigationController.swift
//  swift-calculator
//
//  Created by Abi  Radzhabova on 8/11/21.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal )
    }
    
    func setupNavigationBar() {
        self.navigationBar.tintColor = .white
        self.navigationBar.barTintColor = UIColor(hexString: "#035397")
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
