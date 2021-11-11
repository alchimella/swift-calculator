//
//  Double+Extension.swift
//  swift-calculator
//
//  Created by Abi  Radzhabova on 11/11/21.
//

import Foundation

extension Double {
    
    func isInteger() -> String {
        return floor(self) == self ? String(Int(self)) : String(self)
    }
}
