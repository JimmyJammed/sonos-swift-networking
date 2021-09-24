//
//  File.swift
//  
//
//  Created by James Hickman on 2/10/21.
//

import Foundation
import Alamofire

/// Sonos API wrapper for refreshing the authentication token.
public class AuthenticationRefreshTokenNetwork: Network {
    
    // MARK: - Private Vars
    
    private var refreshToken: String
    private var encodedKeys: String
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    
    /// Initializes an instance of AuthenticationRefreshTokenNetwork for requesting a refreshed authentication token.
    /// - Parameters:
    ///   - refreshToken: The refresh token for which you are requesting an access_token.
    ///   - encodedKeys: The Base64-encoded string of your client ID and secret using a colon as a delimiter to encode any non-HTTP-compatible characters.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    /// - Important: Requires a call to `performRequest()` to make the request.
    public init(refreshToken: String,
                encodedKeys: String,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.refreshToken = refreshToken
        self.encodedKeys = encodedKeys
        self.successHandler = success
        self.failureHandler = failure
    }
    
    // MARK: - Network
    
    override func HTTPMethod() -> HTTPMethod {
        return .post
    }

    override func preparedURL() -> URLConvertible {
        return "https://api.sonos.com/login/v3/oauth/access"
    }

    override func headers() -> HTTPHeaders? {
        let headers = [
            HTTPHeader(name: "Content-Type", value: "application/x-www-form-urlencoded;charset=utf-8"),
            HTTPHeader(name: "Authorization", value: "Basic \(encodedKeys)")
        ]

        return HTTPHeaders(headers)
    }
    
    override func parameters() -> Parameters? {
        let parameters = [
            "grant_type": "refresh_token",
            "refresh_token": refreshToken
        ]
        
        return parameters
    }
    
    override func success(_ data: Data?) {
        successHandler(data)
    }
    
    override func failure(_ error: Error?) {
        failureHandler(error)
    }

}
