//
//  URLSessionLogger.swift
//  UntappdKit
//
//  Created by Mathijs Bernson on 07/11/2024.
//

import Foundation
import os.log

class URLSessionLogger {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "URLSessionLogger", category: "Network")

    // Log request details
    func logRequest(_ request: URLRequest) {
        guard let url = request.url else {
            logger.error("Request URL is nil")
            return
        }

        let method = request.httpMethod ?? "UNKNOWN METHOD"
        let headers = request.allHTTPHeaderFields ?? [:]
        let body = request.httpBody.map { String(decoding: $0, as: UTF8.self) } ?? "No body"

        logger.info("Request: \(method, privacy: .public) \(url.absoluteString, privacy: .public)")
        logger.info("Headers: \(headers.description, privacy: .public)")
        logger.info("Body: \(body, privacy: .public)")
    }

    // Log response details
    func logResponse(data: Data?, response: URLResponse?) {
        guard let response = response as? HTTPURLResponse else {
            logger.error("No valid HTTPURLResponse received")
            return
        }

        let statusCode = response.statusCode
        let headers = response.allHeaderFields

        logger.info("Response Status: \(statusCode, privacy: .public)")
        logger.info("Headers: \(headers.description, privacy: .public)")

        if let data = data, let responseBody = String(data: data, encoding: .utf8) {
            logger.info("Body: \(responseBody, privacy: .public)")
        } else {
            logger.info("No response body")
        }
    }
}
