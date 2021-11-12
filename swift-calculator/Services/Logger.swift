//
//  Logger.swift
//  swift-calculator
//
//  Created by Abi  Radzhabova on 11/11/21.
//

import Foundation

struct Log: Codable {
    
    var logLabel: String
    var sysError: String
    var localTime: String
    var time: String
    var serviceName: String
    var trace: String
    var debug: String
    var info: String
    var warn: String
    var error: String
}

class Logger {
    
    enum LogType: String {
        case trace
        case debug
        case info
        case warn
        case error
        case fatal
    }
    
    static let shared = Logger()
    
    private let serviceName = "swift-calculator-ios"
    
    private var logMode: LogType
        
    private init() {
        self.logMode = .trace
    }
        
    func setLog(type: LogType, message: String) {
        
        var logObject: Log = Log(logLabel: type.rawValue,
                                 sysError: "",
                                 localTime: Date().getFormattedDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZZ"),
                                 time: Date().getFormattedDate(format: "yyyy-MM-dd'T'HH:mm:ss'Z'"),
                                 serviceName: serviceName,
                                 trace: "",
                                 debug: "",
                                 info: "",
                                 warn: "",
                                 error: "")
        
        switch type {
        case .trace:
            logObject.trace = message
        case .debug:
            logObject.debug = message
        case .info:
            logObject.info = message
        case .warn:
            logObject.warn = message
        case .error:
            logObject.error = message
        case .fatal:
            logObject.sysError = message
        }
                
        if type == .fatal {
            print("# FATAL:", logObject)
        }
        
        if type == .error {
            if logMode == .fatal {
                return
            } else {
                print("# ERROR:", logObject)
            }
        }
        
        if type == .warn {
            if logMode == .fatal || logMode == .error {
                return
            } else {
                print("# WARN:", logObject)
            }
        }
        
        if type == .info {
            if logMode == .fatal || logMode == .error || logMode == .warn {
                return
            } else {
                print("# INFO:", logObject)
            }
        }
        
        if type == .debug {
            if logMode == .fatal || logMode == .error || logMode == .warn || logMode == .info {
                return
            } else {
                print("# DEBUG:", logObject)
            }
        }
        
        if type == .trace {
            if logMode == .fatal || logMode == .error || logMode == .warn || logMode == .info || logMode == .debug {
                return
            } else {
                print("# TRACE:", logObject)
            }
        }
    }
}
