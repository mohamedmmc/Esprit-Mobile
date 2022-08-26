//
//  Category.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 17/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation
struct Category: Codable {
    let id: ID
    let title, createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, createdAt, lastUpdateAt
    }
}
