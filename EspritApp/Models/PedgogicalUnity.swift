//
//  PedgogigalUnit.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 21/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation
struct PedagogicalUnity: Codable {
    let id, label, responsible: String
    let office: FromOffice
    let departement: FromDepartement
    let description, createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case label, responsible, office, departement
        case description = "description"
        case createdAt, lastUpdateAt
    }
}

struct FromPedgogicalUnity: Codable {
    let id:ID
    let label, responsible: String
    let office: FromOffice
    let departement: FromDepartement
    let description, createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case label, responsible, office, departement
        case description = "description"
        case createdAt, lastUpdateAt
    }
}
