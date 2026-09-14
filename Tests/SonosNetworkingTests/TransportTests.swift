import Foundation
import Testing
@testable import SonosNetworking

actor Stub: HTTPTransport {
    var responses: [HTTPResponse]
    var requests: [URLRequest] = []
    init(_ responses: [HTTPResponse]) { self.responses = responses }
    func send(_ request: URLRequest) async throws -> HTTPResponse {
        requests.append(request)
        return responses.removeFirst()
    }
}

@Test func requestAndDecode() async throws {
    let stub = Stub([HTTPResponse(status: 200, data: Data(#"{"households":[{"id":"one"}]}"#.utf8))])
    let result = try await SonosHTTPClient(transport: stub).send(Endpoints.householdsGetHouseholds(), accessToken: "secret")
    #expect(result.households?.first?.id == "one")
    let request = await stub.requests.first!
    #expect(request.url?.absoluteString == "https://api.ws.sonos.com/control/api/v1/households")
    #expect(request.value(forHTTPHeaderField: "Authorization") == "Bearer secret")
}
@Test func emptySuccessAndEncodedIdentifier() async throws {
    let stub = Stub([HTTPResponse(status: 204)])
    _ = try await SonosHTTPClient(transport: stub).send(Endpoints.playbackPlayGroupId(groupId: "a/b"), accessToken: "x")
    #expect(await stub.requests.first?.url?.absoluteString.contains("a%2Fb") == true)
}
@Test func getRetriesButPostDoesNot() async throws {
    let stub = Stub([HTTPResponse(status: 503), HTTPResponse(status: 200, data: Data(#"{"households":[]}"#.utf8))])
    _ = try await SonosHTTPClient(transport: stub, sleep: { _ in }).send(Endpoints.householdsGetHouseholds(), accessToken: "x")
    #expect(await stub.requests.count == 2)
    let post = Stub([HTTPResponse(status: 503)])
    await #expect(throws: NetworkError.self) {
        _ = try await SonosHTTPClient(transport: post).send(Endpoints.playbackPlayGroupId(groupId: "a"), accessToken: "x")
    }
    #expect(await post.requests.count == 1)
}
@Test func retriesAreBounded() async throws {
    let stub = Stub(Array(repeating: HTTPResponse(status: 429, headers: ["Retry-After": "0"]), count: 3))
    await #expect(throws: NetworkError.self) {
        _ = try await SonosHTTPClient(transport: stub, sleep: { _ in }).send(Endpoints.householdsGetHouseholds(), accessToken: "x")
    }
    #expect(await stub.requests.count == 3)
}
@Test func authAndMalformedResponses() async throws {
    for response in [HTTPResponse(status: 401), HTTPResponse(status: 200, data: Data("not json".utf8)), HTTPResponse(status: 200)] {
        let stub = Stub([response])
        await #expect(throws: NetworkError.self) {
            _ = try await SonosHTTPClient(transport: stub).send(Endpoints.householdsGetHouseholds(), accessToken: "x")
        }
        #expect(await stub.requests.count == 1)
    }
}
@Test func cancellationDoesNotSend() async throws {
    let stub = Stub([])
    let task = Task {
        withUnsafeCurrentTask { $0?.cancel() }
        _ = try await SonosHTTPClient(transport: stub).send(Endpoints.householdsGetHouseholds(), accessToken: "x")
    }
    await #expect(throws: CancellationError.self) { try await task.value }
    #expect(await stub.requests.isEmpty)
}
