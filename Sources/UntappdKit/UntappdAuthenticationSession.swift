//
//  UntappdAuthenticationSession.swift
//  UntappdKit
//
//  Created by Mathijs Bernson on 06/11/2024.
//

import Foundation
import AuthenticationServices

/// A class that lets the user authenticate with Untappd via a web session.
/// The main function is `authenticate()` which returns an Untappd token or throws an error on failure/cancellation.
public class UntappdAuthenticationSession: NSObject, ASWebAuthenticationPresentationContextProviding {
    let clientID: String
    let clientSecret: String
    let redirectURL: URL
    let urlScheme: String
    let presentationAnchor: ASPresentationAnchor

    public init(
        clientID: String,
        clientSecret: String,
        redirectURL: URL,
        urlScheme: String,
        presentationAnchor: ASPresentationAnchor
    ) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.redirectURL = redirectURL
        self.urlScheme = urlScheme
        self.presentationAnchor = presentationAnchor
    }

    public func authenticate() async throws -> UntappdToken {
        let code = try await performLogin()
        return try await authenticate(code: code)
    }

    private func performLogin() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            var authURLComponents = URLComponents(string: "https://untappd.com/oauth/authenticate/")!
            authURLComponents.queryItems = [
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "client_id", value: clientID),
                URLQueryItem(name: "redirect_url", value: redirectURL.absoluteString),
            ]
            let authURL = authURLComponents.url!

            let session = ASWebAuthenticationSession(url: authURL, callback: .customScheme(urlScheme)) { url, error in
                if let url {
                    let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
                    if let code = components?.queryItems?.first(where: { $0.name == "code" })?.value {
                        continuation.resume(returning: code)
                    } else {
                        let error = UntappdAuthenticationError(errorDescription: "No authentication code in redirect URL")
                        continuation.resume(throwing: error)
                    }
                } else if let error {
                    continuation.resume(throwing: error)
                } else {
                    assertionFailure()
                }
            }
            session.presentationContextProvider = self
            session.start()
        }
    }

    private func authenticate(code: String) async throws -> UntappdToken {
        var authURLComponents = URLComponents(string: "https://untappd.com/oauth/authorize/")!
        authURLComponents.queryItems = [
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "client_secret", value: clientSecret),
            URLQueryItem(name: "redirect_url", value: redirectURL.absoluteString),
            URLQueryItem(name: "code", value: code),
        ]
        let authURL = authURLComponents.url!

        let (data, _) = try await URLSession.shared.data(from: authURL)
        let decoder = JSONDecoder()
        let response = try decoder.decode(UntappdAuthResponse.self, from: data)
        return UntappdToken(accessToken: response.response.accessToken)
    }

    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        presentationAnchor
    }
}

private struct UntappdAuthResponse: Decodable {
    let response: UntappdAuthToken
}

private struct UntappdAuthToken: Decodable {
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}

public struct UntappdToken: Sendable {
    public let accessToken: String

    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}

private struct UntappdAuthenticationError: LocalizedError {
    let errorDescription: String?
}
