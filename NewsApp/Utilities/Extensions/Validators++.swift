//
//  Validators++.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import Foundation

class Validators {
    
    static func nonEmptyValidator(value: String) -> Bool {
        return !value.isEmpty
    }
    
    static  func isValidPasswordValidator(value: String) -> Bool {
        return value.count > 7
    }
    
    static func confirmPasswordValidator(value: String, value2: String?) -> Bool {
        return value.count >= 7 && value == value2
    }
    
    static func matcherValidator(value: String, value2: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: value2)
            let range = NSRange(location: 0, length: value.utf16.count)
            let matches = regex.matches(in: value, options: [], range: range)
            return !matches.isEmpty
        } catch {
            return false
        }
    }
    
    static func isValidEmailValidator(value: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: value.utf16.count)
            let matches = regex.matches(in: value, options: [], range: range)
            return !matches.isEmpty
        } catch {
            return false
        }
    }
    
    
    static func isValidNameValidator(value: String) -> Bool {
        let pattern = "^(?! )[A-Za-z\\s]+$"
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: value.utf16.count)
            let matches = regex.matches(in: value, options: [], range: range)
            return !matches.isEmpty
        } catch {
            return false
        }
    }
    
}
