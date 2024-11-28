//
//  UntappdResponse.swift
//  UntappdKit
//
//  Created by Mathijs Bernson on 06/11/2024.
//

import Foundation

struct UntappdResponse<Content: Decodable>: Decodable {
    let meta: UntappdResponseMeta
    let response: Content
}

struct UntappdResponseMeta: Decodable {
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case statusCode = "code"
    }
}
