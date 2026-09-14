# Sonos Swift Networking

Swift 6 · iOS 18+ / macOS 15+ · MIT · 2.0.0

Foundation-only asynchronous networking for the Sonos Control API. Typed request factories and Codable models, injectable transport, explicit HTTP errors, and bounded read retries.

## Run the fixture demo

```sh
git clone https://github.com/JimmyJammed/sonos-swift-networking.git
cd sonos-swift-networking
swift run sonos-networking-demo
swift test
```

Requires Swift tools 6.3+ (Xcode 26.6+). No credentials or speaker is required. The demo prints a fictional household. `SONOS_ACCESS_TOKEN=... swift run sonos-networking-demo --live` opts into live reads.

## Integrate

Add this repository in Xcode's Package Dependencies and select **SonosNetworking**. Use the 2.0 release tag when available or the exact modernization commit.

```swift
import SonosNetworking
let client = try SonosHTTPClient()
let households = try await client.send(
    Endpoints.householdsGetHouseholds(), accessToken: accessToken)
```

The application supplies an access token from its authentication backend. Never embed a Sonos client secret in distributed app code.

[Setup](docs/GETTING_STARTED.md) · [API](docs/API.md) · [Endpoint matrix](docs/ENDPOINTS.md) · [Customization](docs/CUSTOMIZATION.md) · [Architecture](docs/ARCHITECTURE.md) · [Migration](docs/MIGRATION.md) · [Testing](docs/TESTING.md) · [Validation](docs/VALIDATION.md) · [Troubleshooting](docs/TROUBLESHOOTING.md)

## License

[MIT](LICENSE). Sonos is a third-party service; this project is unaffiliated with Sonos. API schema provenance is linked per endpoint. Existing attribution remains intact.
