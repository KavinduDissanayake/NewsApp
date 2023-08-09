//
//  AppConfig.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-07.
//

import Foundation

final class AppConfig {
    
    enum Key: String {
        case apiKey = "API_KEY"
        case baseURL = "BASE_URL"
    }
    
    static func getValueFor(_ key: Key) -> String? {
        guard let dictionary = Bundle.main.object(forInfoDictionaryKey: "AppConfig") as? [String: String] else { return nil }
        return dictionary[key.rawValue]
    }
    
    
    static func getValueForURL(_ key: Key) -> String? {
        guard let dictionary = Bundle.main.object(forInfoDictionaryKey: "AppConfig") as? [String: String] else { return nil }
        let newUrl = dictionary[key.rawValue]?.replacingOccurrences(of: "\\/", with: "/")
        return newUrl
    }
}
