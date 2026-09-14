# Validation — 2026-09-14

Local Mac, Xcode 26.6 (17F113), Apple Swift 6.3.3.

- `swift test`: seven Swift Testing tests passed. The XCTest runner reports zero because these tests use Swift Testing.
- `swift run sonos-networking-demo`: decoded fictional household successfully.
- Independent SPM consumer: built and ran against the package product.
- `xcodebuild -scheme SonosNetworking -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO build`: succeeded with the installed iOS SDK.

Tests cover encoded identifiers, corrected endpoint paths, JSON bodies, empty success, malformed responses, 401, bounded 429/503 retries, no automatic POST retry, and cancellation.

Xcode 27, iOS 18/27 runtimes, and physical Sonos/account tests were unavailable. Generic simulator compilation is not runtime validation. Source reconciliation covers 61 Control API factories; it does not certify every endpoint against live hardware. No release tag or registry publication is implied by the 2.0 documentation.
