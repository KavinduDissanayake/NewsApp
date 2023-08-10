//
//  NewsEverythingResponse.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsEverythingResponse = try? JSONDecoder().decode(NewsEverythingResponse.self, from: jsonData)

import Foundation

// MARK: - NewsEverythingResponse
struct NewsEverythingResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
//    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}
