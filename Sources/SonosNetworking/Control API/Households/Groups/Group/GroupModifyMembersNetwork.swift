//
//  File.swift
//
//
//  Created by James Hickman on 2/17/21.
//

import Foundation
import Alamofire

/// GroupModifyMembersNetwork is used to add players to and remove players from a group. In response to this command, Sonos first adds players to the group, then removes players from the group.
public class GroupModifyMembersNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var groupId: String
    private var playerIdsToAdd: [String]
    private var playerIdsToRemove: [String]
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of GroupModifyMembersNetwork for modifying the members.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - groupId: The group for which to modify the members in.
    ///   - playerIdsToAdd: An array of player ID strings of players to add to the group.
    ///   - playerIdsToRemove: An array of player ID strings of players to remove from the group.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                groupId: String,
                playerIdsToAdd: [String],
                playerIdsToRemove: [String],
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.groupId = groupId
        self.playerIdsToAdd = playerIdsToAdd
        self.playerIdsToRemove = playerIdsToRemove
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
        return "https://api.ws.sonos.com/control/api/v1/groups/\(groupId)/groups/modifyGroupMembers"
    }

    override func headers() -> HTTPHeaders? {
        let headers = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)")
        ]

        return HTTPHeaders(headers)
    }
        
    override func parameters() -> Parameters? {
        let parameters: [String: Any] = [
            "playerIdsToAdd": playerIdsToAdd,
            "playerIdsToRemove": playerIdsToRemove
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
