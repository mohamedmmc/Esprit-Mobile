//
//  Evenement.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 18/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation
struct Evenement: Codable {
    let id, title, description, startDate: String
    let endDate: String
    let likes: Int
    let place: Place
    let createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case description = "description"
        case startDate, endDate, likes, place, createdAt, lastUpdateAt
    }
}

