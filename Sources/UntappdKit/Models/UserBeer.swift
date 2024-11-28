//
//  UserBeer.swift
//  UntappdKit
//
//  Created by Mathijs Bernson on 06/11/2024.
//

import Foundation

public struct UserBeersResponse: Codable, Sendable {
    public let totalCount: Int
    public let dates: Dates
    // public let isSearch: Bool
    // public let typeID, countryID: String
    // public let breweryID, ratingScore, regionID, containerID: Bool
    // public let isMultiType: Bool
    public let beers: Beers
//    public let sort, sortKey, sortName: String
    public let pagination: Pagination

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case dates
//        case isSearch = "is_search"
//        case sort
//        case typeID = "type_id"
//        case countryID = "country_id"
//        case breweryID = "brewery_id"
//        case ratingScore = "rating_score"
//        case regionID = "region_id"
//        case containerID = "container_id"
//        case isMultiType = "is_multi_type"
        case beers
//        case sortKey = "sort_key"
//        case sortName = "sort_name"
        case pagination
    }

    // MARK: - Dates
    public struct Dates: Codable, Sendable {
        public let firstCheckinDate: String
        public let startDate, endDate: Bool
        public let tzOffset: String

        enum CodingKeys: String, CodingKey {
            case firstCheckinDate = "first_checkin_date"
            case startDate = "start_date"
            case endDate = "end_date"
            case tzOffset
        }
    }

    // MARK: - Beers
    public struct Beers: Codable, Sendable {
        public let count: Int
        public let items: [UserBeer]
        public let sortEnglish, sortName: String

        enum CodingKeys: String, CodingKey {
            case count, items
            case sortEnglish = "sort_english"
            case sortName = "sort_name"
        }
    }
}

// MARK: - UserBeer
public struct UserBeer: Codable, Sendable {
    public let firstCheckinID: Int
    public let firstCreatedAt: Date
    public let recentCheckinID: Int
    public let recentCreatedAt: Date
    public let recentCreatedAtTimezone: Int
    public let ratingScore: Double
    public let userAuthRatingScore: Double
    public let firstHad: Date
    public let count: Int
    public let beer: Beer
    public let brewery: Brewery

    enum CodingKeys: String, CodingKey {
        case firstCheckinID = "first_checkin_id"
        case firstCreatedAt = "first_created_at"
        case recentCheckinID = "recent_checkin_id"
        case recentCreatedAt = "recent_created_at"
        case recentCreatedAtTimezone = "recent_created_at_timezone"
        case ratingScore = "rating_score"
        case userAuthRatingScore = "user_auth_rating_score"
        case firstHad = "first_had"
        case count, beer, brewery
    }
}

// MARK: - Beer
public struct Beer: Codable, Sendable {
    public let bid: Int
    public let beerName: String
    public let beerLabel: String
    public let beerAbv: Double
    public let beerIbu: Double
    public let beerSlug, beerStyle, beerDescription: String
    public let createdAt: Date
    public let ratingScore: Double
    public let ratingCount: Int
    public let hasHad: Bool?

    enum CodingKeys: String, CodingKey {
        case bid
        case beerName = "beer_name"
        case beerLabel = "beer_label"
        case beerAbv = "beer_abv"
        case beerIbu = "beer_ibu"
        case beerSlug = "beer_slug"
        case beerStyle = "beer_style"
        case beerDescription = "beer_description"
        case createdAt = "created_at"
        case ratingScore = "rating_score"
        case ratingCount = "rating_count"
        case hasHad = "has_had"
    }
}

// MARK: - Brewery
public struct Brewery: Codable, Sendable {
    public let breweryID: Int
    public let breweryName, brewerySlug, breweryPageURL: String
    public let breweryType: String
    public let breweryLabel: String
    public let countryName: String
    public let contact: Contact
    public let location: Location
    public let breweryActive: Int

    enum CodingKeys: String, CodingKey {
        case breweryID = "brewery_id"
        case breweryName = "brewery_name"
        case brewerySlug = "brewery_slug"
        case breweryPageURL = "brewery_page_url"
        case breweryType = "brewery_type"
        case breweryLabel = "brewery_label"
        case countryName = "country_name"
        case contact, location
        case breweryActive = "brewery_active"
    }
}

// MARK: - Contact
public struct Contact: Codable, Sendable {
    public let twitter: String
    public let facebook: String
    public let instagram: String
    public let url: String
}

// MARK: - Location
public struct Location: Codable, Sendable {
    public let breweryCity, breweryState: String
    public let lat, lng: Double

    enum CodingKeys: String, CodingKey {
        case breweryCity = "brewery_city"
        case breweryState = "brewery_state"
        case lat, lng
    }
}

// MARK: - Pagination
public struct Pagination: Codable, Sendable {
    public let sinceURL: String?
    public let nextURL: String?
    public let offset: Int?
    // public let maxID: Bool

    enum CodingKeys: String, CodingKey {
        case sinceURL = "since_url"
        case nextURL = "next_url"
        case offset
        // case maxID = "max_id"
    }
}
