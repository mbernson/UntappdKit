//
//  UntappdClient.swift
//  UntappdKit
//
//  Created by Mathijs Bernson on 04/11/2024.
//

import Foundation

/// Main class for accessing the Untappd API.
///
/// A delegate conforming to `UntappdClientDelegate` should be provided to make authenticated requests.
public class UntappdClient {
    let session: URLSession
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    let dateFormatter: DateFormatter
    let baseURL: URL
    let logger = URLSessionLogger()
    public weak var delegate: UntappdClientDelegate?

    public init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        baseURL = URL(string: "https://api.untappd.com/v4/")!
    }

    // MARK: Info / Search

    public func userBeers(
        username: String? = nil,
        offset: Int? = nil,
        limit: Int = 50,
        sort: String = "date"
    ) async throws -> UserBeersResponse {
        var parameters = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "sort", value: String(sort)),
        ]
        if let offset {
            parameters.append(URLQueryItem(name: "offset", value: String(offset)))
        }
        return if let username {
            try await request(path: "user/beers/\(username)", parameters: parameters)
        } else {
            try await request(path: "user/beers", parameters: parameters)
        }
    }
    
    public func searchBeerByName(_ beerName: String, breweryName: String?) async throws -> SearchBeerResponse {
        var queryName = beerName
        if let breweryName {
            queryName = "\(breweryName) \(queryName)"
        }
        let parameters: [URLQueryItem] = [
            URLQueryItem(name: "q", value: queryName),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "limit", value: "1")
        ]
        return try await request(path: "search/beer", parameters: parameters)
    }
    
    public func getBeerInfo(beerId: Int) async throws -> GetBeerResponse {
        return try await request(path: "beer/info/\(beerId)")
    }

    // MARK: Basic requests

    func request<ResponseType: Decodable>(
        method: String = "GET",
        path: String,
        parameters: [URLQueryItem]? = nil
    ) async throws -> ResponseType {
        var request = URLRequest(url: requestURL(path: path, parameters: parameters))
        request.httpMethod = method
        logger.logRequest(request)
        let (data, urlResponse) = try await session.data(for: request)
        logger.logResponse(data: data, response: urlResponse)
        do {
            let untappdResponse = try decoder.decode(UntappdResponse<ResponseType>.self, from: data)
            try validate(urlResponse)
            return untappdResponse.response
        } catch {
            do {
                if let untappdErrorResponse = try? decoder.decode(UntappdErrorResponse.self, from: data) {
                    throw untappdErrorResponse.meta
                } else {
                    throw error
                }
            }
        }
    }

    func requestURL(path: String, parameters: [URLQueryItem]?) -> URL {
        var components = URLComponents(url: baseURL.appending(path: path), resolvingAgainstBaseURL: true)!
        var queryItems: [URLQueryItem] = components.queryItems ?? []
        if let token = delegate?.token {
            queryItems.append(URLQueryItem(name: "access_token", value: token.accessToken))
        }
        if let parameters {
            queryItems.append(contentsOf: parameters)
        }
        components.queryItems = queryItems
        return components.url!
    }

    func validate(_ response: URLResponse) throws {
        guard let urlResponse = response as? HTTPURLResponse else {
            throw UntappdAPIError.invalidResponse
        }
        let statusCode = urlResponse.statusCode
        switch statusCode {
        case 200..<300:
            // Successful response, no error to throw
            break
        case 300..<400:
            throw UntappdAPIError.redirectionError(statusCode: statusCode)
        case 400..<500:
            throw UntappdAPIError.clientError(statusCode: statusCode)
        case 500..<600:
            throw UntappdAPIError.serverError(statusCode: statusCode)
        default:
            throw UntappdAPIError.unknown
        }
    }
}

public protocol UntappdClientDelegate: AnyObject {
    /// The Untappd access token that is used to make authenticated requests.
    var token: UntappdToken? { get }
}
