//
//  Building.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 19/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation

struct Building: Codable {
    let id, label: String
    let lang, lat: Double
    let createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case label, lang, lat, createdAt, lastUpdateAt
    }
}

struct FromBuilding: Codable {
    let id: ID
    let label: String
    let lang, lat: Double
    let createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case label, lang, lat, createdAt, lastUpdateAt
    }
}
