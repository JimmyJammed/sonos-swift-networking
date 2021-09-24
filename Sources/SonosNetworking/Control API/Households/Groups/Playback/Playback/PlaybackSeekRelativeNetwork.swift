//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackSeekRelativeNetwork is used to seek to the a relative position in the current track. Optionally add the cloud queue itemId to target a specific track.
/// Use itemId to ensure the group seeks on the current item. If the current item’s itemId does not match the one provided, the player returns ERROR_INVALID_OBJECT_ID.
public class PlaybackSeekRelativeNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var groupId: String
    private var itemId: String?
    private var deltaMillis: Int
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackSeekRelativeNetwork for going to a relative position in the current track.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - groupId: This command requires a groupId to determine the target of the command.
    ///   - itemId: The identifier for the item. If this parameter does not match the currently playing item, the command fails. This ensures that playback does not jump back to a track if a user starts to scrub just as the player begins to play the next item.
    ///   - deltaMillis: Relative position within track in milliseconds. If this value exceeds the current track duration time, Sonos moves to the end of the current track, which results in a skip to the next track.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                groupId: String,
                itemId: String? = nil,
                deltaMillis: Int,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.groupId = groupId
        self.itemId = itemId
        self.deltaMillis = deltaMillis
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
        return "https://api.ws.sonos.com/control/api/v1/groups/\(groupId)/playback/seekRelative"
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
        var parameters: [String: Any] = [
            "deltaMillis": deltaMillis
        ]
        
        if let itemId = itemId {
            parameters["itemId"] = itemId
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
