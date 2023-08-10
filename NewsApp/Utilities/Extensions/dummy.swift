//
//  dummy.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import Foundation

// Assuming you've already defined Article and Source structs as above

// MARK: - Dummy Data Generation
let dummySource1 = Source(id: nil, name: "The News Times")
let dummySource2 = Source(id: nil, name: "Tech Today")

let dummyArticle1 = Article(
//    source: dummySource1,
    author: "John Doe",
    title: "Breaking: The world is round!",
    description: "Scientists have finally concluded that the world is indeed round.",
    url: "https://www.thenewstimes.com/world-round",
    urlToImage: "https://www.thenewstimes.com/images/world-round.jpg",
    publishedAt: "2023-08-10T14:00:00Z",
    content: "For years, people believed that the Earth was flat, but new evidence suggests otherwise. Scientists from around the globe have been investigating this theory for years..."
)

let dummyArticle2 = Article(
//    source: dummySource2,
    author: "Jane Smith",
    title: "The Future of Tech: AI Leads the Way",
    description: "The advancements in artificial intelligence are changing the landscape of technology.",
    url: "https://www.techtoday.com/ai-future",
    urlToImage: "https://www.techtoday.com/images/ai.jpg",
    publishedAt: "2023-08-10T14:00:00Z",
    content: "Artificial intelligence has become the cornerstone of modern technology. From smartphones to autonomous vehicles, AI is everywhere..."
)

let dummArticlesList = [dummyArticle1, dummyArticle2]

