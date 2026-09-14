# API

`SonosHTTPClient(transport:baseURL:timeout:maxRetries:sleep:)` is Sendable. Defaults are URLSession, the HTTPS Sonos v1 control base URL, 15 seconds, and at most two GET retries. Configurations reject invalid timeouts, non-HTTPS base URLs, and retry counts outside 0...5.

`send(_:accessToken:) async throws -> Response` validates 2xx status and decodes the endpoint's response. HTTP errors retain status and optional JSON details. Empty bodies are valid only for EmptyResponse or Ok. Malformed required response bodies raise decoding errors.

Endpoints factories cover the requests in ENDPOINTS.md. Bodies and response models use Codable/Sendable. Optional fields follow the retrieved schemas; open string enums remain strings to tolerate future values. JSONValue handles open-ended data.

Endpoint exposes query and headers for optional parameters such as X-Sonos-Api-Key. Authorization is always supplied by the client. `encoding(body)` adds a custom Encodable body when a published endpoint schema omits its body definition. Playback-session seek bodies should be supplied this way; schema coverage is not equivalent to live verification.

HTTPTransport.send(URLRequest) enables fixtures and custom networking. URLSessionTransport accepts a custom URLSession. GET retries handle selected transient transport failures and HTTP 429/502/503/504. Retry-After numeric seconds are bounded to 30; other values use exponential delay. Writes and deletes are never retried automatically. Task cancellation propagates without retry.
