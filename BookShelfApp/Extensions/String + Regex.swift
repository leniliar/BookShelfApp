//
//  String + Regex.swift
//  BookShelfApp
//
//  Created by user on 3.02.23.
//
import UIKit

extension String {
    
    enum ValidityType {
        case email
        case password
    }
    
    enum Regex: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
    }
    
    func textfieldIsValid(_ validitiType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validitiType {
        case .email:
            regex = Regex.email.rawValue
        case.password: regex = Regex.password.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
