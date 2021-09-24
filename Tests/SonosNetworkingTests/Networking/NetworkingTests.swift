import XCTest
@testable import SonosNetworking
@testable import Alamofire
@testable import Mocker

final class NetworkingTests: XCTestCase {
    private var subject: MockNetworking!

    static var allTests = [
        ("testHTTPMethod", testHTTPMethod),
        ("testEncoding", testEncoding),
        ("testPreparedUrl", testPreparedUrl),
        ("testHeaders", testHeaders),
        ("testParameters", testParameters),
        ("testPerformRequest", testPerformRequest),
        ("testSuccess", testSuccess),
        ("testFailure", testFailure),
    ]

    override func setUp() {
        subject = MockNetworking()
    }
    
    override func tearDown() {
        subject = nil
    }
    
    func testHTTPMethod() {
        XCTAssertFalse(subject.didCallHTTPMethod)
        XCTAssertEqual(subject.HTTPMethod(), MockedData.expectedHTTPMethod)
        XCTAssertTrue(subject.didCallHTTPMethod)
    }
    
    func testEncoding() {
        XCTAssertFalse(subject.didCallEncoding)
        XCTAssertNotNil(subject.encoding() as? URLEncoding)
        XCTAssertTrue(subject.didCallEncoding)
    }
    
    func testPreparedUrl() {
        XCTAssertFalse(subject.didCallPreparedUrl)
        XCTAssertEqual(try subject.preparedURL().asURL(), try MockedData.expectedPreparedUrl.asURL())
        XCTAssertTrue(subject.didCallPreparedUrl)
    }
    
    func testHeaders() {
        XCTAssertFalse(subject.didCallHeaders)
        XCTAssertEqual(subject.headers()?.dictionary, MockedData.expectedHeaders.dictionary)
        XCTAssertTrue(subject.didCallHeaders)
    }
    
    func testParameters() {
        XCTAssertFalse(subject.didCallParameters)
        XCTAssertEqual(subject.parameters()?.keys, MockedData.expectedParameters.keys)
        XCTAssertEqual(subject.parameters()?.count, MockedData.expectedParameters.count)
        XCTAssertTrue(subject.didCallParameters)
    }
    
    func testPerformRequest() {
        XCTAssertFalse(subject.didCallPerformRequest)
        do {
            let url = try subject.preparedURL().asURL()
            let mockedData = try JSONSerialization.data(withJSONObject: MockedData.expectedResults, options: [])
            let mock = Mock(url: url, ignoreQuery: true, dataType: .json, statusCode: 200, data: [.get: mockedData])
            mock.register()
            subject.performRequest()
            XCTAssertTrue(subject.didCallPerformRequest)
        } catch let error {
            assertionFailure("Failed to create URL from provided string: \(error.localizedDescription)")
        }
    }
            
    func testSuccess() {
        XCTAssertFalse(subject.didSucceed)
        do {
            let url = try subject.preparedURL().asURL()
            let mockedData = try JSONSerialization.data(withJSONObject: MockedData.expectedResults, options: [])
            let mock = Mock(url: url, ignoreQuery: true, dataType: .json, statusCode: 200, data: [.get: mockedData])
            mock.register()
            subject.performRequest()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                XCTAssertTrue(self.subject.didFail)
            }
        } catch let error {
            assertionFailure("Failed to create URL from provided string: \(error.localizedDescription)")
        }
    }

    func testFailure() {
        XCTAssertFalse(subject.didFail)
        do {
            let url = try subject.preparedURL().asURL()
            let mockedData = try JSONSerialization.data(withJSONObject: MockedData.expectedResults, options: [])
            let error = AFError.ServerTrustFailureReason.noPublicKeysFound.underlyingError
            let mock = Mock(url: url, ignoreQuery: true, dataType: .json, statusCode: 400, data: [.get: mockedData], requestError: error)
            mock.register()
            subject.performRequest()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                XCTAssertTrue(self.subject.didFail)
            }
        } catch let error {
            assertionFailure("Failed to create URL from provided string: \(error.localizedDescription)")
        }
    }
    
}

fileprivate final class MockedData {

    public static let expectedHTTPMethod: HTTPMethod = .get
    public static let expectedEncoding: ParameterEncoding = URLEncoding.default
    public static let expectedPreparedUrl: URLConvertible = "https://sonos.com"
    public static let expectedHeaders: HTTPHeaders = [
        HTTPHeader(name: "Content-Type", value: "application/json"),
        HTTPHeader(name: "Authorization", value: "Bearer abc123")
    ]
    public static let expectedParameters: Parameters = [
        "id": "abc123",
        "name": "testing"
    ]
    public static let expectedResults: [String: Any] = [
        "key": "value"
    ]

}

fileprivate class MockNetworking: Network {
    var didCallHTTPMethod = false
    var didCallEncoding = false
    var didCallPreparedUrl = false
    var didCallHeaders = false
    var didCallParameters = false
    var didCallPerformRequest = false
    var didSucceed = false
    var didFail = false
        
    override init() {
        super.init()
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        session = Alamofire.Session(configuration: configuration)
    }

    override func HTTPMethod() -> HTTPMethod {
        didCallHTTPMethod = true
        return MockedData.expectedHTTPMethod
    }
    
    override func encoding() -> ParameterEncoding {
        didCallEncoding = true
        return MockedData.expectedEncoding
    }
    
    override func preparedURL() -> URLConvertible {
        didCallPreparedUrl = true
        return MockedData.expectedPreparedUrl
    }
    
    override func headers() -> HTTPHeaders? {
        didCallHeaders = true
        return MockedData.expectedHeaders
    }
    
    override func parameters() -> Parameters? {
        didCallParameters = true
        return MockedData.expectedParameters
    }
    
    override func performRequest() {
        didCallPerformRequest = true
        super.performRequest()
    }
    
    override func success(_: Data?) {
        didSucceed = true
    }
    
    override func failure(_: Error?) {
        didFail = true
    }
    
}
