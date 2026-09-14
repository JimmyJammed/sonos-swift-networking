import Foundation
import SonosNetworking

struct Fixture: HTTPTransport {
    func send(_ request: URLRequest) async throws -> HTTPResponse {
        HTTPResponse(status: 200, data: Data(#"{"households":[{"id":"demo-household"}]}"#.utf8))
    }
}
let live = CommandLine.arguments.contains("--live")
let token = ProcessInfo.processInfo.environment["SONOS_ACCESS_TOKEN"] ?? "fixture"
if live && token == "fixture" { fatalError("Set SONOS_ACCESS_TOKEN for --live") }
let transport: any HTTPTransport = live ? URLSessionTransport() : Fixture()
let client = try SonosHTTPClient(transport: transport)
let result = try await client.send(Endpoints.householdsGetHouseholds(), accessToken: token)
print(String(data: try JSONEncoder().encode(result), encoding: .utf8)!)
