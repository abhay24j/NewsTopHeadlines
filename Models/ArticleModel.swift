//
//  ArticleModel.swift
//  NewsUpdate
//
//  Created by Abhay Kumar on 12/06/22.
//

import Foundation

struct ArticleModel: Codable {
    let source: SourceModel?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}
