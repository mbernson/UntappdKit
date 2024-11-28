//
//  SearchBeer.swift
//  UntappdKit
//
//  Created by Parsa Nasirimehr on 2024-11-22.
//

import Foundation

// MARK: - ListBeerResponse
public struct SearchBeerResponse: Codable, Sendable {
    let found, offset, limit: Int
    let term, parsedTerm: String
    public let beers, homebrew: Beers
    let breweries: Breweries

    enum CodingKeys: String, CodingKey {
        case found, offset, limit, term
        case parsedTerm = "parsed_term"
        case beers, homebrew, breweries
    }
}

// MARK: - Beers
public struct Beers: Codable, Sendable {
    let count: Int
    public let items: [BeersItem]
}

// MARK: - BeersItem
public struct BeersItem: Codable, Sendable {
    public let checkinCount: Int
    public let haveHad: Bool
    public let yourCount: Int
    public var beer: SearchBeer
    public let brewery: PurpleBrewery

    enum CodingKeys: String, CodingKey {
        case checkinCount = "checkin_count"
        case haveHad = "have_had"
        case yourCount = "your_count"
        case beer, brewery
    }
}

// MARK: - Beer
public struct SearchBeer: Codable, Sendable {
    public let bid: Int
    public let beerName: String
    public let beerLabel: String
    public let beerAbv: Double
    public let beerIbu: Int
    public let beerSlug: String
    public let beerDescription, createdAt, beerStyle: String
    public var authRating: Double
    public let wishList: Bool
    public let inProduction: Int

    enum CodingKeys: String, CodingKey {
        case bid
        case beerName = "beer_name"
        case beerLabel = "beer_label"
        case beerAbv = "beer_abv"
        case beerIbu = "beer_ibu"
        case beerDescription = "beer_description"
        case createdAt = "created_at"
        case beerStyle = "beer_style"
        case authRating = "auth_rating"
        case wishList = "wish_list"
        case inProduction = "in_production"
        case beerSlug = "beer_slug"
    }
}

// MARK: - PurpleBrewery
public struct PurpleBrewery: Codable, Sendable {
    public let breweryID: Int
    public let breweryName: String
    public let brewerySlug: String
    public let breweryLabel: String
    public let countryName: String
    public let contact: SearchContact
    public let location: SearchLocation
    public let breweryActive: Int

    enum CodingKeys: String, CodingKey {
        case breweryID = "brewery_id"
        case breweryName = "brewery_name"
        case brewerySlug = "brewery_slug"
        case breweryLabel = "brewery_label"
        case countryName = "country_name"
        case contact, location
        case breweryActive = "brewery_active"
    }
}

// MARK: - Contact
public struct SearchContact: Codable, Sendable {
    let twitter: String
    let facebook: String
    let instagram: String
    let url: String
}

// MARK: - Location
public struct SearchLocation: Codable, Sendable {
    let breweryCity: String
    let breweryState: String
    let lat, lng: Double

    enum CodingKeys: String, CodingKey {
        case breweryCity = "brewery_city"
        case breweryState = "brewery_state"
        case lat, lng
    }
}

// MARK: - Breweries
struct Breweries: Codable, Sendable {
    let items: [BreweriesItem]
    let count: Int
}

// MARK: - BreweriesItem
struct BreweriesItem: Codable, Sendable {
    let brewery: FluffyBrewery
}

// MARK: - FluffyBrewery
struct FluffyBrewery: Codable, Sendable {
    let breweryID, beerCount: Int
    let breweryName: String
    let breweryLabel: String
    let countryName: String
    let location: SearchLocation

    enum CodingKeys: String, CodingKey {
        case breweryID = "brewery_id"
        case beerCount = "beer_count"
        case breweryName = "brewery_name"
        case breweryLabel = "brewery_label"
        case countryName = "country_name"
        case location
    }
}
