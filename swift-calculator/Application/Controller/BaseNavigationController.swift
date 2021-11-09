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
        
        
    }
    
    func swtupNavigationBar() {
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
        navigationBar.backgroundColor = UIColor(hexString: "#035397")
    }
}
