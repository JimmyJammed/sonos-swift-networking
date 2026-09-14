# Migrating from 1.x

Replace request-class construction plus performRequest callbacks with an Endpoints factory and `try await client.send`. Replace Alamofire Session with URLSessionTransport or HTTPTransport. Public models are now Codable and Sendable.

Consult LEGACY_ENDPOINTS for every former class and ENDPOINTS for its current path. Duplicate legacy volume/metadata/list wrappers collapse to one factory. GroupSetMembers now targets groupId; PlayerSetMute targets /mute; PlaybackSessionCreate targets /playbackSession. Old undocumented APIs are explicitly unsupported, not silently redirected.

OAuth token/refresh requests move to the SDK's server example or your own backend. Remove app-bundled client secrets. Requires iOS 18/macOS 15 and Swift tools 6.3. This is a 2.0 API break.
