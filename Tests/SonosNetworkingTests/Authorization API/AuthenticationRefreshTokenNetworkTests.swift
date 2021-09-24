//
//  File.swift
//
//
//  Created by James Hickman on 2/28/21.
//

import XCTest
@testable import SonosNetworking
@testable import Alamofire
@testable import Mocker

final class AuthenticationRefreshTokenNetworkTests: XCTestCase {
    private var subject: AuthenticationRefreshTokenNetwork!
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
        subject = AuthenticationRefreshTokenNetwork(refreshToken: MockedData.refreshToken,
                                                    encodedKeys: MockedData.encodedKeys,
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
        XCTAssertNotNil(subject.encoding() as? URLEncoding)
    }
    
    func testPreparedUrl() {
        XCTAssertEqual(try subject.preparedURL().asURL(), try MockedData.expectedPreparedUrl.asURL())
    }
    
    func testHeaders() {
        XCTAssertEqual(subject.headers()?.dictionary, MockedData.expectedHeaders.dictionary)
    }
    
    func testParameters() {
        XCTAssertEqual(subject.parameters()?.keys, MockedData.expectedParameters.keys)
        XCTAssertEqual(subject.parameters()?.count, MockedData.expectedParameters.count)
    }
    
    func testSuccess() {
        XCTAssertFalse(didSucceed)
        do {
            let url = try subject.preparedURL().asURL()
            let mockedData = try JSONSerialization.data(withJSONObject: MockedData.expectedResults, options: [])
            let mock = Mock(url: url, dataType: .json, statusCode: 200, data: [.post: mockedData])
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
            let mock = Mock(url: url, dataType: .json, statusCode: 400, data: [.post: Data()], requestError: error)
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
    
    public static let encodedKeys: String = "encodedKeys"
    public static let refreshToken: String = "refreshToken"

    public static let expectedHTTPMethod: HTTPMethod = .post
    public static let expectedEncoding: ParameterEncoding = URLEncoding.default
    public static let expectedPreparedUrl: URLConvertible = "https://api.sonos.com/login/v3/oauth/access"
    public static let expectedHeaders: HTTPHeaders = [
        HTTPHeader(name: "Content-Type", value: "application/x-www-form-urlencoded;charset=utf-8"),
        HTTPHeader(name: "Authorization", value: "Basic \(encodedKeys)")
    ]
    public static let expectedParameters: Parameters = [
        "grant_type": "refresh_token",
        "refresh_token": refreshToken
    ]
    public static let expectedResults: [String: Any] = [
        "access_token": "a5771c41-f3e3-45de-a0dc-311ff03816dc",
        "token_type": "Bearer",
        "expires_in": 86400,
        "refresh_token": "5f6e38ed-144e-43a1-abd8-98449cd0a3a3",
        "scope": "scope_test"
    ]

}
