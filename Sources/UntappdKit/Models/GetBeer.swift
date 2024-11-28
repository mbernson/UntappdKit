//
//  GetBeer.swift
//  UntappdKit
//
//  Created by Parsa Nasirimehr on 2024-11-22.
//

import Foundation

// MARK: - GetBeerResponse
public struct GetBeerResponse: Codable {
    public let beer: GetBeerResponseBeer
}

// MARK: - GetBeerResponseBeer
public struct GetBeerResponseBeer: Codable {
//    let bid: Int
//    let beerName: String
//    let beerLabel: String
//    let beerAbv: Double
//    let beerIbu: Int
//    let beerDescription, beerStyle: String
//    let isInProduction: Int
//    let beerSlug: String
//    let isHomebrew: Int
//    let createdAt: String
//    let ratingCount: Int
    public let ratingScore: Double
//    let stats: Stats
//    let brewery: GetBeerBrewery
//    let authRating: Int
//    let wishList: Bool
//    let media: Media
//    let similar: Similar
//    let friends, vintages: Friends

    enum CodingKeys: String, CodingKey {
//        case bid
//        case beerName = "beer_name"
//        case beerLabel = "beer_label"
//        case beerAbv = "beer_abv"
//        case beerIbu = "beer_ibu"
//        case beerDescription = "beer_description"
//        case beerStyle = "beer_style"
//        case isInProduction = "is_in_production"
//        case beerSlug = "beer_slug"
//        case isHomebrew = "is_homebrew"
//        case createdAt = "created_at"
//        case ratingCount = "rating_count"
        case ratingScore = "rating_score"
//        case stats, brewery
//        case authRating = "auth_rating"
//        case wishList = "wish_list"
//        case media, similar, friends, vintages
    }
}

// MARK: - Brewery
struct GetBeerBrewery: Codable {
    let breweryID: Int
    let breweryName: String
    let breweryLabel: String
    let countryName: String
    let contact: BreweryContact
    let location: BreweryLocation
    let brewerySlug: String?
    let breweryActive: Int?

    enum CodingKeys: String, CodingKey {
        case breweryID = "brewery_id"
        case breweryName = "brewery_name"
        case breweryLabel = "brewery_label"
        case countryName = "country_name"
        case contact, location
        case brewerySlug = "brewery_slug"
        case breweryActive = "brewery_active"
    }
}

// MARK: - BreweryContact
struct BreweryContact: Codable {
    let twitter: String
    let facebook, url: String
    let instagram: String?
}

// MARK: - BreweryLocation
struct BreweryLocation: Codable {
    let breweryCity, breweryState: String
    let lat, lng: Double

    enum CodingKeys: String, CodingKey {
        case breweryCity = "brewery_city"
        case breweryState = "brewery_state"
        case lat, lng
    }
}

// MARK: - Friends
struct Friends: Codable {
    let items: [Item]
    let count: Int
}

// MARK: - Item
struct Item: Codable {
    let categoryName, categoryID: String?
    let isPrimary: Bool?
    let beer: ItemBeer?

    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case categoryID = "category_id"
        case isPrimary = "is_primary"
        case beer
    }
}

// MARK: - ItemBeer
struct ItemBeer: Codable {
    let bid: Int
    let beerLabel: String
    let beerSlug, beerName: String
    let isVintage, isVariant: Int

    enum CodingKeys: String, CodingKey {
        case bid
        case beerLabel = "beer_label"
        case beerSlug = "beer_slug"
        case beerName = "beer_name"
        case isVintage = "is_vintage"
        case isVariant = "is_variant"
    }
}

// MARK: - Media
struct Media: Codable {
    let count: Int
    let items: MediaItems
}

// MARK: - MediaItems
struct MediaItems: Codable {
    let photoID: Int
    let photo: Photo
    let createdAt: String
    let checkinID: Int
    let beer: PurpleBeer
    let brewery: GetBeerBrewery
    let user: User
    let venue: [Venue]

    enum CodingKeys: String, CodingKey {
        case photoID = "photo_id"
        case photo
        case createdAt = "created_at"
        case checkinID = "checkin_id"
        case beer, brewery, user, venue
    }
}

// MARK: - PurpleBeer
struct PurpleBeer: Codable {
    let bid: Int
    let beerName: String
    let beerLabel: String
    let beerAbv: Double
    let beerIbu: Int
    let beerSlug, beerDescription: String
    let isInProduction, beerStyleID: Int
    let beerStyle: String
    let authRating: Int
    let wishList: Bool
    let beerActive: Int

    enum CodingKeys: String, CodingKey {
        case bid
        case beerName = "beer_name"
        case beerLabel = "beer_label"
        case beerAbv = "beer_abv"
        case beerIbu = "beer_ibu"
        case beerSlug = "beer_slug"
        case beerDescription = "beer_description"
        case isInProduction = "is_in_production"
        case beerStyleID = "beer_style_id"
        case beerStyle = "beer_style"
        case authRating = "auth_rating"
        case wishList = "wish_list"
        case beerActive = "beer_active"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let photoImgSm, photoImgMd, photoImgLg, photoImgOg: String

    enum CodingKeys: String, CodingKey {
        case photoImgSm = "photo_img_sm"
        case photoImgMd = "photo_img_md"
        case photoImgLg = "photo_img_lg"
        case photoImgOg = "photo_img_og"
    }
}

// MARK: - User
struct User: Codable {
    let uid: Int
    let userName, firstName, lastName: String
    let userAvatar: String
    let relationship: String
    let isPrivate: Int

    enum CodingKeys: String, CodingKey {
        case uid
        case userName = "user_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case userAvatar = "user_avatar"
        case relationship
        case isPrivate = "is_private"
    }
}

// MARK: - Venue
struct Venue: Codable {
    let venueID: Int
    let venueName, primaryCategory, parentCategoryID: String
    let categories: Friends
    let location: VenueLocation
    let contact: VenueContact
    let privateVenue: Bool
    let foursquare: Foursquare
    let venueIcon: VenueIcon

    enum CodingKeys: String, CodingKey {
        case venueID = "venue_id"
        case venueName = "venue_name"
        case primaryCategory = "primary_category"
        case parentCategoryID = "parent_category_id"
        case categories, location, contact
        case privateVenue = "private_venue"
        case foursquare
        case venueIcon = "venue_icon"
    }
}

// MARK: - VenueContact
struct VenueContact: Codable {
    let twitter, venueURL: String

    enum CodingKeys: String, CodingKey {
        case twitter
        case venueURL = "venue_url"
    }
}

// MARK: - Foursquare
struct Foursquare: Codable {
    let foursquareID: String
    let foursquareURL: String

    enum CodingKeys: String, CodingKey {
        case foursquareID = "foursquare_id"
        case foursquareURL = "foursquare_url"
    }
}

// MARK: - VenueLocation
struct VenueLocation: Codable {
    let venueAddress, venueCity, venueState: String
    let lat, lng: Double

    enum CodingKeys: String, CodingKey {
        case venueAddress = "venue_address"
        case venueCity = "venue_city"
        case venueState = "venue_state"
        case lat, lng
    }
}

// MARK: - VenueIcon
struct VenueIcon: Codable {
    let sm, md, lg: String
}

// MARK: - Similar
struct Similar: Codable {
    let count: Int
    let items: SimilarItems
}

// MARK: - SimilarItems
struct SimilarItems: Codable {
    let ratingScore: Double
    let beer: FluffyBeer
    let brewery: GetBeerBrewery
    let friends: Friends

    enum CodingKeys: String, CodingKey {
        case ratingScore = "rating_score"
        case beer, brewery, friends
    }
}

// MARK: - FluffyBeer
struct FluffyBeer: Codable {
    let bid: Int
    let beerName: String
    let beerAbv: Double
    let beerIbu: Int
    let beerStyle: String
    let beerLabel: String
    let authRating: Int
    let wishList: Bool

    enum CodingKeys: String, CodingKey {
        case bid
        case beerName = "beer_name"
        case beerAbv = "beer_abv"
        case beerIbu = "beer_ibu"
        case beerStyle = "beer_style"
        case beerLabel = "beer_label"
        case authRating = "auth_rating"
        case wishList = "wish_list"
    }
}

// MARK: - Stats
struct Stats: Codable {
    let totalCount, monthlyCount, totalUserCount, userCount: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case monthlyCount = "monthly_count"
        case totalUserCount = "total_user_count"
        case userCount = "user_count"
    }
}

