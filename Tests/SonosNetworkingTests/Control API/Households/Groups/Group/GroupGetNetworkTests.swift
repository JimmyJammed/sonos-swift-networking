//
//  File.swift
//
//
//  Created by James Hickman on 2/26/21.
//

import XCTest
@testable import SonosNetworking
@testable import Alamofire
@testable import Mocker

final class GroupGetNetworkTests: XCTestCase {
    private var subject: GroupGetNetwork!
    private var completionExpectation: XCTestExpectation?

    private var didSucceed = false
    private var didFail = false
    private var responseData: Data?
    private var responseError: Error?

    static var allTests = [
        ("testHTTPMethod", testHTTPMethod),
        ("testEncoding", testEncoding),
        ("testPreparedUrl", testPreparedUrl),
        ("testHeaders", testHeaders),
        ("testParameters", testParameters),
        ("testSuccess", testSuccess),
        ("testFailure", testFailure),
    ]
    
    override func setUp() {
        subject = GroupGetNetwork(accessToken: MockedData.accessToken,
                               householdId: MockedData.householdId,
                               success: { [weak self] data in
                                self?.didSucceed = true
                                self?.responseData = data
                                self?.completionExpectation?.fulfill()
                               },
                               failure: { [weak self] error in
                                self?.didFail = true
                                self?.responseError = error
                                self?.completionExpectation?.fulfill()
                               })

        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        subject.session = Alamofire.Session(configuration: configuration)
    }
    
    override func tearDown() {
        subject = nil
        completionExpectation = nil
        responseData = nil
        responseError = nil
    }
    
    func testHTTPMethod() {
        XCTAssertEqual(subject.HTTPMethod(), MockedData.expectedHTTPMethod)
    }
    
    func testEncoding() {
        XCTAssertNotNil(subject.encoding() as? JSONEncoding)
    }
    
    func testPreparedUrl() {
        XCTAssertEqual(try subject.preparedURL().asURL(), try MockedData.expectedPreparedUrl.asURL())
    }
    
    func testHeaders() {
        XCTAssertEqual(subject.headers()?.dictionary, MockedData.expectedHeaders.dictionary)
    }
    
    func testParameters() {
        XCTAssertNil(subject.parameters())
    }
    
    func testSuccess() {
        XCTAssertFalse(didSucceed)
        do {
            let url = try subject.preparedURL().asURL()
            let mockedData = try JSONSerialization.data(withJSONObject: MockedData.expectedResults, options: [])
            let mock = Mock(url: url, dataType: .json, statusCode: 200, data: [.get: mockedData])
            mock.register()

            let completionExpectation = expectation(description: "Request should succeed.")
            self.completionExpectation = completionExpectation

            subject.performRequest()
            wait(for: [completionExpectation], timeout: 1.0)
            XCTAssertTrue(self.didSucceed)
            guard let responseData = self.responseData else {
                assertionFailure("Response data should not be nil.")
                return
            }
            XCTAssertEqual(mockedData, responseData)
        } catch let error {
            assertionFailure("Failed to create URL from provided string: \(error.localizedDescription)")
        }
    }

    func testFailure() {
        XCTAssertFalse(didFail)
        do {
            let url = try subject.preparedURL().asURL()
            let error = AFError.ServerTrustFailureReason.noPublicKeysFound.underlyingError
            let mock = Mock(url: url, dataType: .json, statusCode: 400, data: [.get: Data()], requestError: error)
            mock.register()

            let completionExpectation = expectation(description: "Request should fail.")
            self.completionExpectation = completionExpectation

            subject.performRequest()
            wait(for: [completionExpectation], timeout: 1.0)
            XCTAssertTrue(didFail)
        } catch let error {
            assertionFailure("Failed to create URL from provided string: \(error.localizedDescription)")
        }
    }
    
}

fileprivate final class MockedData {
    
    public static let accessToken: String = "accessToken"
    public static let householdId: String = "householdId"
    
    public static let expectedHTTPMethod: HTTPMethod = .get
    public static let expectedEncoding: ParameterEncoding = JSONEncoding.default
    public static let expectedPreparedUrl: URLConvertible = "https://api.ws.sonos.com/control/api/v1/households/\(householdId)/groups"
    public static let expectedHeaders: HTTPHeaders = [
        HTTPHeader(name: "Content-Type", value: "application/json"),
        HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)")
    ]
    public static let expectedResults: [String: Any] = [
        "players": [
            [
              "name": "p5",
              "websocketUrl": "wss://11.0.11.7:1443/websocket/api",
              "deviceIds": [
                "RINCON_7DQQGH13GH4Q12345"
              ],
              "id": "RINCON_7DQQGH13GH4Q12345",
              "icon": "livingroom"
            ],
            [
              "name": "pb",
              "websocketUrl": "wss://11.0.11.14:1443/websocket/api",
              "deviceIds": [
                "RINCON_Z0X1234G34H654321",
                "RINCON_070E58F007BC01499",
                "RINCON_A9E93789CRT201577"
              ],
              "id": "RINCON_Z0X1234G34H654321",
              "icon": "livingroom"
            ]
          ],
          "groups": [
            [
              "playerIds": [
                "RINCON_7DQQGH13GH4Q12345"
              ],
              "playbackState": "PLAYBACK_STATE_IDLE",
              "coordinatorId": "RINCON_7DQQGH13GH4Q12345",
              "id": "RINCON_7DQQGH13GH4Q12345:218",
              "name": "p5"
            ],
            [
              "playerIds": [
                "RINCON_Z0X1234G34H654321"
              ],
              "playbackState": "PLAYBACK_STATE_IDLE",
              "coordinatorId": "RINCON_Z0X1234G34H654321",
              "id": "RINCON_Z0X1234G34H654321:15",
              "name": "pb"
            ]
          ]
    ]

}
