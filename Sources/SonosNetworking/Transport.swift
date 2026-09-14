import Foundation

public enum JSONValue: Codable, Sendable, Equatable {
    case string(String), number(Double), bool(Bool), object([String: JSONValue]), array([JSONValue]), null
    public init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        if c.decodeNil() { self = .null }
        else if let v = try? c.decode(Bool.self) { self = .bool(v) }
        else if let v = try? c.decode(Double.self) { self = .number(v) }
        else if let v = try? c.decode(String.self) { self = .string(v) }
        else if let v = try? c.decode([String: JSONValue].self) { self = .object(v) }
        else { self = .array(try c.decode([JSONValue].self)) }
    }
    public func encode(to encoder: Encoder) throws {
        var c = encoder.singleValueContainer()
        switch self {
        case .string(let v): try c.encode(v)
        case .number(let v): try c.encode(v)
        case .bool(let v): try c.encode(v)
        case .object(let v): try c.encode(v)
        case .array(let v): try c.encode(v)
        case .null: try c.encodeNil()
        }
    }
}
public struct EmptyResponse: Codable, Sendable, Equatable { public init() {} }

public struct Endpoint<Response: Decodable & Sendable>: Sendable {
    public let segments: [String]
    public let method: String
    public var body: Data?
    public var query: [String: String] = [:]
    public var headers: [String: String] = [:]
    public func encoding<Body: Encodable>(_ body: Body) throws -> Self {
        var copy = self
        copy.body = try JSONEncoder().encode(body)
        return copy
    }
    public init(segments: [String], method: String = "GET", body: Data? = nil) {
        self.segments = segments; self.method = method; self.body = body
    }
}

public struct HTTPResponse: Sendable {
    public let status: Int
    public let data: Data
    public let headers: [String: String]
    public init(status: Int, data: Data = Data(), headers: [String: String] = [:]) {
        self.status = status; self.data = data; self.headers = headers
    }
}
public protocol HTTPTransport: Sendable {
    func send(_ request: URLRequest) async throws -> HTTPResponse
}
public struct URLSessionTransport: HTTPTransport {
    private let session: URLSession
    public init(session: URLSession = .shared) { self.session = session }
    public func send(_ request: URLRequest) async throws -> HTTPResponse {
        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
        return HTTPResponse(status: http.statusCode, data: data, headers: http.allHeaderFields.reduce(into: [:]) { result, item in
            result[String(describing: item.key).lowercased()] = String(describing: item.value)
        })
    }
}
public enum NetworkError: Error, Sendable {
    case invalidResponse
    case invalidConfiguration
    case invalidPath
    case http(status: Int, details: JSONValue?)
    case decoding(String)
}

public struct SonosHTTPClient: Sendable {
    private let transport: any HTTPTransport
    private let baseURL: URL
    private let timeout: TimeInterval
    private let maxRetries: Int
    private let sleep: @Sendable (Double) async throws -> Void
    public init(transport: any HTTPTransport = URLSessionTransport(),
                baseURL: URL = URL(string: "https://api.ws.sonos.com/control/api/v1")!,
                timeout: TimeInterval = 15, maxRetries: Int = 2,
                sleep: @escaping @Sendable (Double) async throws -> Void = { try await Task.sleep(for: .seconds($0)) }) throws {
        guard timeout.isFinite, timeout > 0, (0...5).contains(maxRetries), baseURL.scheme == "https", baseURL.host != nil else {
            throw NetworkError.invalidConfiguration
        }
        self.transport = transport; self.baseURL = baseURL; self.timeout = timeout
        self.maxRetries = maxRetries; self.sleep = sleep
    }
    public func send<Response>(_ endpoint: Endpoint<Response>, accessToken: String) async throws -> Response {
        try Task.checkCancellation()
        guard !accessToken.isEmpty else { throw NetworkError.invalidConfiguration }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        let allowed = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "-._~"))
        guard endpoint.segments.allSatisfy({ !$0.isEmpty && $0 != "." && $0 != ".." }) else { throw NetworkError.invalidPath }
        components.percentEncodedPath += "/" + endpoint.segments.map { $0.addingPercentEncoding(withAllowedCharacters: allowed)! }.joined(separator: "/")
        if !endpoint.query.isEmpty { components.queryItems = endpoint.query.sorted { $0.key < $1.key }.map { URLQueryItem(name: $0.key, value: $0.value) } }
        guard let url = components.url else { throw NetworkError.invalidPath }
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.body
        for (key, value) in endpoint.headers { request.setValue(value, forHTTPHeaderField: key) }
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if endpoint.body != nil { request.setValue("application/json", forHTTPHeaderField: "Content-Type") }
        for attempt in 0...maxRetries {
            try Task.checkCancellation()
            let response: HTTPResponse
            do { response = try await transport.send(request) }
            catch {
                try Task.checkCancellation()
                if endpoint.method == "GET", attempt < maxRetries,
                   let e = error as? URLError, [.timedOut, .networkConnectionLost, .cannotConnectToHost].contains(e.code) {
                    try await sleep(min(pow(2, Double(attempt)), 10)); continue
                }
                throw error
            }
            try Task.checkCancellation()
            if !(200...299).contains(response.status) {
                if endpoint.method == "GET", attempt < maxRetries, [429, 502, 503, 504].contains(response.status) {
                    let seconds = Double(response.headers.first { $0.key.lowercased() == "retry-after" }?.value ?? "") ?? pow(2, Double(attempt))
                    try await sleep(seconds.isFinite ? min(max(seconds, 0), 30) : 1); continue
                }
                throw NetworkError.http(status: response.status, details: try? JSONDecoder().decode(JSONValue.self, from: response.data))
            }
            if response.data.isEmpty {
                if let empty = EmptyResponse() as? Response { return empty }
                if let ok = Ok() as? Response { return ok }
            }
            do { return try JSONDecoder().decode(Response.self, from: response.data) }
            catch { throw NetworkError.decoding(String(describing: error)) }
        }
        throw NetworkError.invalidResponse
    }
}
