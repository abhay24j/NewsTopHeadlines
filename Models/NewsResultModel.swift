//
//  NewsResultModel.swift
//  NewsUpdate
//
//  Created by Abhay Kumar on 12/06/22.
//

import Foundation

struct NewsResultModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleModel]
}
