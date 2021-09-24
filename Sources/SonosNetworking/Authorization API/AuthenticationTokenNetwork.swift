//
//  File.swift
//  
//
//  Created by James Hickman on 2/9/21.
//

import Foundation
import Alamofire

/// Sonos API wrapper for requesting an authentication token.
public class AuthenticationTokenNetwork: Network {
    
    // MARK: - Private Vars
    
    private var authorizationCode: String
    private var encodedKeys: String
    private var redirectURI: String
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of AuthenticationTokenNetwork for requesting an authentication token. Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - authorizationCode: The authorization code provided by the `Create Authorization Code API`.
    ///   - encodedKeys: The Base64-encoded string of your client ID and secret using a colon as a delimiter to encode any non-HTTP-compatible characters.
    ///   - redirectURI: URI of the site that requested the authorization code. This must match one of the redirect URLs that you provided for your client credentials in the integration manager. This must be a client-side request as the Sonos login service displays Web pages to the user to prompt them to login to their Sonos account and allow your integration to access and control their Sonos household.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(authorizationCode: String,
                encodedKeys: String,
                redirectURI: String,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.authorizationCode = authorizationCode
        self.encodedKeys = encodedKeys
        self.redirectURI = redirectURI
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
            "grant_type": "authorization_code",
            "code": authorizationCode,
            "redirect_uri": redirectURI
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
