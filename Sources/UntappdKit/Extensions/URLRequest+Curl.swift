//
//  URLRequest+Curl.swift
//  UntappdKit
//
//  Created by Mathijs Bernson on 07/11/2024.
//

import Foundation

extension URLRequest {
    var curlCommand: String {
        guard let url else { return "" }

        var command = "curl"

        // Add HTTP method
        if let httpMethod, httpMethod != "GET" {
            command += " -X \(httpMethod)"
        }

        // Add headers
        if let allHTTPHeaderFields {
            for (key, value) in allHTTPHeaderFields {
                command += " -H '\(key): \(value)'"
            }
        }

        // Add body if available
        if let httpBody,
           let bodyString = String(data: httpBody, encoding: .utf8) {
            command += " -d '\(bodyString)'"
        }

        // Add URL
        command += " '\(url.absoluteString)'"

        return command
    }
}
