//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackGetStatusNetwork is used to get the current playback status (transport state) for the group, such as PLAYBACK_STATE_IDLE, PLAYBACK_STATE_BUFFERING, or PLAYBACK_STATE_PLAYING. 
public class PlaybackGetStatusNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var groupId: String
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackGetStatusNetwork for getting the current plyaback status.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - groupId: This command requires a groupId to determine the target of the command.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                groupId: String,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.groupId = groupId
        self.successHandler = success
        self.failureHandler = failure
    }
    
    // MARK: - Network
    
    override func encoding() -> ParameterEncoding {
        return JSONEncoding.default
    }
    
    override func preparedURL() -> URLConvertible {
        return "https://api.ws.sonos.com/control/api/v1/groups/\(groupId)/playback"
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