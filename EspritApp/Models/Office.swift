//
//  Office.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 20/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation

// MARK: - Office
struct Office: Codable {
    let id: ID
    let label: String
    let floor, number: Int
    let building: Building
    let createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case label, floor, number, building, createdAt, lastUpdateAt
    }
}

struct FromOffice: Codable {
    let id: ID
    let label: String
    let floor, number: Int
    let building: FromBuilding
    let createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case label, floor, number, building, createdAt, lastUpdateAt
    }
}
