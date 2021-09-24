//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// GroupVolumeSetNetwork is used to set group volume to a specific level and unmute the group if muted.
/// When your app sets the group volume, the group coordinator calculates the required changes to the volume level for each player in the group so that the result is the average volume level of the group as a whole. The group coordinator then adjusts its local volume and initiates network transactions with the other players in the group to adjust their volumes accordingly. While players adjust their volumes, the group coordinator may generate one or more groupVolume events.
/// Since this command can generate additional network transactions and events, your app should optimize how often it is invoked to maintain a good user experience without flooding the network, such as when implementing a touch screen volume slider that controls a group of five players.
public class GroupVolumeSetNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var groupId: String
    private var volume: Int
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of GroupVolumeSetNetwork to set group volume to a specific level and unmute the group if muted.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - groupId: This command requires a groupId to determine the target of the command.
    ///   - volume: The new group volume as an integer between 0 and 100, inclusive. If your app submits a number outside of this range, you will receive an ERROR_INVALID_PARAMETER error.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                groupId: String,
                volume: Int,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.groupId = groupId
        self.volume = volume
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
        return "https://api.ws.sonos.com/control/api/v1/groups/\(groupId)/groupVolume"
    }

    override func headers() -> HTTPHeaders? {
        let headers = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)")
        ]

        return HTTPHeaders(headers)
    }
        
    override func parameters() -> Parameters? {
        let parameters = ["volume": volume]
        
        return parameters
    }

    override func success(_ data: Data?) {
        successHandler(data)
    }
    
    override func failure(_ error: Error?) {
        failureHandler(error)
    }

}
