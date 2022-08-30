//
//  Model.swift
//  AsyncAwaitSample
//
//  Created by 이재웅 on 2022/08/30.
//

import Foundation

struct SomeModel: Codable {
    let page, perPage, total, totalPages: Int
    let data: [ImageModel]
    let support: Support

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

struct ImageModel: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

struct Support: Codable {
    let url: String
    let text: String
}
