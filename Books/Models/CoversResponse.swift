//
//  CoversResponse.swift
//  Books
//
//  Created by Ростислав Ермаченков on 09.03.2021.
//

import Foundation

import Foundation

// MARK: - CoversResponseElement
struct CoversResponseElement: Codable {
    let textID, title: String
    let image: String
    let rating: Double
    let coversResponseDescription, author: String

    enum CodingKeys: String, CodingKey {
        case textID = "textId"
        case title, image, rating
        case coversResponseDescription = "description"
        case author
    }
}

typealias CoversResponse = [CoversResponseElement]
