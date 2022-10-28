//
//  NewsModel.swift
//  Home
//
//  Created by Nguyen Huy Khoi on 28/10/2022.
//

import Foundation

class NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [News]
}

class News: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
