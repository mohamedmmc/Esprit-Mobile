//
//  ID.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 17/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation

// MARK: - ID
struct ID: Codable {
    let bsontype: String
    let id: IDClass

    enum CodingKeys: String, CodingKey {
        case bsontype = "_bsontype"
        case id
    }
}
