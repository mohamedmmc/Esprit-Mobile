//
//  Post.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 17/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation

struct Posts: Decodable{
    var posts: [Post]?
}

struct Post: Codable {
    let id, title, content: String
    let likes, views: Int
    let isPublished: Bool
    let category: Category
    let images: [Image]
    let createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, content, likes, views, isPublished, category, images, createdAt, lastUpdateAt
    }
}

