//
//  Desk.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 20/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Desk: Codable {
    let id, label, description, insuredBy: String
    let office: Office
    let files: [Image]
    let createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case label
        case description
        case insuredBy, office, files, createdAt, lastUpdateAt
    }
}

struct FromDesk: Codable {
    let id, label, description, insuredBy: String
    let office: FromOffice
    let files: [Image]
    let createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case label
        case description
        case insuredBy, office, files, createdAt, lastUpdateAt
    }
}

