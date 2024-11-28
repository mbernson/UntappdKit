//
//  UntappdErrorResponse.swift
//  UntappdKit
//
//  Created by Mathijs Bernson on 23/11/2024.
//

import Foundation

struct UntappdErrorResponse: Decodable {
    let meta: UntappdErrorResponseMeta
}

struct UntappdErrorResponseMeta: Error, Decodable {
    let code: Int
    let errorDetail: String
    let errorType: String
    let developerFriendly: Bool?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case errorDetail = "error_detail"
        case errorType = "error_type"
        case developerFriendly = "developer_friendly"
    }
}

extension UntappdErrorResponseMeta: LocalizedError {
    var errorDescription: String? { errorDetail }
    var failureReason: String? { errorType }
}
