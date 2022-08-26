//
//  Teacher.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 22/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation

struct Teacher: Codable {
    let id, firstName, lastName, email: String
    let avatar: Image
    let description: String
    let pedagogicalUnit: FromPedgogicalUnity
    let isResponsible: Bool
    let responsibleOf: String
    let pedagogicalUnitResponsible : FromPedgogicalUnity?
    let departementResponsible: FromDepartement?
    let createdAt, lastUpdateAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName, lastName, email, avatar,description
        case pedagogicalUnit, isResponsible, responsibleOf, pedagogicalUnitResponsible, departementResponsible, createdAt, lastUpdateAt
    }
}
