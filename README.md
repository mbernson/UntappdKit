# UntappdKit

A client for the [Untappd](https://untappd.com/) API, written in Swift.

It was created during the Q42 hackathon w00tcamp for the [Uncheckd app](https://uncheckd.com/). Check it out!

## Features

* User authentication to Untappd using `ASWebAuthenticationSession`
* Uses modern Swift concurrency (async/await)
* Response validation with error handling, including typed errors
* Request/response logging

## Examples

### Authentication

A helper class `UntappdAuthenticationSession` lets the user log in using their Untappd account.

A [custom URL scheme](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app) must be defined by your app in order to receive the access token.

```swift
import Foundation
import UntappdKit

func signIn() async throws {
    let presentationAnchor = await MainActor.run { UIWindow() }
    let authProvider = await UntappdAuthenticationSession(
        clientID: "...",
        clientSecret: "...",
        redirectURL: URL(string: "myapp://authenticate")!,
        urlScheme: "myapp",
        presentationAnchor: presentationAnchor
    )
    let token = try await authProvider.authenticate()
    print("Received access token: \(token.accessToken)")
    // Store token in the Keychain
}
```

### Fetching user beers

The `UntappdClient` is the main class for accessing the Untappd API.

The offset and limit, combined with the `response.pagination` property may be used to fetch multiple pages of responses.

```swift
func fetchUserBeers() async throws {
    let untappdClient = UntappdClient()
    let response: UserBeersResponse = try await untappdClient.userBeers(offset: 0, limit: 50)
    print("User has \(response.totalCount) total beers checked in")
    for beerItem in response.beers.items {
        print("\(beerItem.beer.beerName) from \(beerItem.brewery.breweryName)")
        print("has \(beerItem.beer.beerAbv)% ABV")
    }
}
```

## API calls that are implemented

### Basics
- [x] Authentication

### Feeds
- [ ] Activity Feed
- [ ] User Activity Feed
- [ ] Venue Activity Feed
- [ ] Beer Activity Feed
- [ ] Brewery Activity Feed
- [ ] Notifications

### Info / Search
- [ ] User Info
- [ ] User Wish List
- [ ] User Friends
- [ ] User Badges
- [x] User Beers
- [ ] Brewery Info
- [x] Beer Info
- [ ] Venue Info
- [x] Beer Search
- [ ] Brewery Search

### Actions
- [ ] Checkin
- [ ] Toast / Un-toast
- [ ] Pending Friends
- [ ] Add Friend
- [ ] Remove Friend
- [ ] Accept Friend
- [ ] Reject Friend
- [ ] Add Comment
- [ ] Remove Comment
- [ ] Add to Wish List
- [ ] Remove from Wish List

See the [Untappd API docs](https://untappd.com/api/docs) for more info about the API calls.

## Contributing

Pull requests are welcome, especially for implementing more of the API.
I used [QuickType](https://quicktype.io) to quickly reverse-engineer the codable models.

## Version history

- 28-11-2024: Initial open source release.
- 22-11-2024: Initial version for the w00tcamp project Uncheckd

## License

MIT licensed, see [LICENSE.md].
