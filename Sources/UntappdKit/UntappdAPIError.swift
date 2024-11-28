//
//  UntappdAPIError.swift
//  UntappdKit
//
//  Created by Mathijs Bernson on 07/11/2024.
//

import Foundation

public enum UntappdAPIError: Error {
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case redirectionError(statusCode: Int)
    case invalidResponse
    case unknown
}
