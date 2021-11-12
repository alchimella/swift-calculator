//
//  Date+Extension.swift
//  swift-calculator
//
//  Created by Abi  Radzhabova on 11/11/21.
//

import Foundation

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        dateformat.timeZone = TimeZone(secondsFromGMT: 0)
        return dateformat.string(from: self)
    }
}
