//
//  File.swift
//  
//
//  Created by James Hickman on 2/10/21.
//

import Foundation
import Alamofire

/// HouseholdNetwork is used to get a list of household IDs for which your app has access. See Authorize for details.
/// The getHouseholds command requests information on the households that can be acted upon, based upon the access token used when calling this API. There are no parameters for this command.
/// If successful, Sonos responds with an array of household objects.
public class HouseholdNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of HouseholdNetwork to get a list of household IDs for which your app has access.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.successHandler = success
        self.failureHandler = failure
    }
    
    // MARK: - Network
    
    override func encoding() -> ParameterEncoding {
        return JSONEncoding.default
    }
    
    override func preparedURL() -> URLConvertible {
        return "https://api.ws.sonos.com/control/api/v1/households"
    }

    override func headers() -> HTTPHeaders? {
        let headers = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)")
        ]

        return HTTPHeaders(headers)
    }
        
    override func success(_ data: Data?) {
        successHandler(data)
    }
    
    override func failure(_ error: Error?) {
        failureHandler(error)
    }
    
}
