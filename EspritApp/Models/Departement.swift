//
//  Departement.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 21/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation
struct Departement: Codable {
    let id, label, responsible, contact: String
    let building: FromBuilding
    let createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case label, responsible, contact, building, createdAt, lastUpdateAt
    }
}

struct FromDepartement: Codable {
    let id: ID
    let label, responsible, contact: String
    let building: FromBuilding
    let createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case label, responsible, contact, building, createdAt, lastUpdateAt
    }
}
