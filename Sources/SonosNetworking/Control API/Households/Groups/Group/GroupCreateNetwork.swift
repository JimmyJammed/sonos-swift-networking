//
//  File.swift
//
//
//  Created by James Hickman on 2/17/21.
//

import Foundation
import Alamofire

/// GroupCreateNetwork is used to create a new group from a list of players. The player returns a group object with the group ID. This may be an existing group ID if an existing group is a subset of the new group. In this case, Sonos may build the new group by adding new players to the existing group.
public class GroupCreateNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var householdId: String
    private var playerIds: [String]
    private var musicContextGroupId: String?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of GroupCreateNetwork for creating a new group.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - householdId: The household for which to create the group in.
    ///   - playerIds: An array of player ID strings to group.
    ///   - musicContextGroupId: The group containing the audio that you want to use. If empty or not provided, the new group will not contain any audio.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                householdId: String,
                playerIds: [String],
                musicContextGroupId: String? = nil,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.householdId = householdId
        self.playerIds = playerIds
        self.musicContextGroupId = musicContextGroupId
        self.successHandler = success
        self.failureHandler = failure
    }
    
    // MARK: - Network
    
    override func HTTPMethod() -> HTTPMethod {
        return .post
    }
    
    override func encoding() -> ParameterEncoding {
        return JSONEncoding.default
    }
    
    override func preparedURL() -> URLConvertible {
        return "https://api.ws.sonos.com/control/api/v1/households/\(householdId)/groups/createGroup"
    }

    override func headers() -> HTTPHeaders? {
        let headers = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)")
        ]

        return HTTPHeaders(headers)
    }
        
    override func parameters() -> Parameters? {
        // Some parameters may trigger a success with error response due to lack of support on the device. Only pass in the requested values to avoid false errors.
        var parameters: [String: Any] = ["playerIds": playerIds]

        if let musicContextGroupId = musicContextGroupId {
            parameters["musicContextGroupId"] = musicContextGroupId
        }
        
        return parameters
    }
    
    override func success(_ data: Data?) {
        successHandler(data)
    }
    
    override func failure(_ error: Error?) {
        failureHandler(error)
    }
    
}
