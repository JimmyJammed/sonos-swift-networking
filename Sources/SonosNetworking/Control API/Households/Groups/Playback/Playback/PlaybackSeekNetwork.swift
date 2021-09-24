//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackSeekNetwork is used to go to a specific position in the current track. Optionally add the cloud queue itemId to target a specific track.
/// Use itemId to ensure the group seeks on the current item. If the current item’s itemId does not match the one provided, the player returns an ERROR_INVALID_OBJECT_ID error.
public class PlaybackSeekNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var groupId: String
    private var itemId: String?
    private var positionMillis: UInt
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackSeekNetwork for going to a specific position in the current track.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - itemId: The identifier for the item. If included and it does not match the currently playing item, the command fails. This ensures that playback does not jump back to a track if a user starts to scrub just as the player begins to play the next item or due to latency.
    ///   - positionMillis: Position within track in milliseconds. If this value exceeds the current track duration time, Sonos moves to the end of the current track, which results in a skip to the next track.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                groupId: String,
                itemId: String? = nil,
                positionMillis: UInt,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.groupId = groupId
        self.itemId = itemId
        self.positionMillis = positionMillis
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
        return "https://api.ws.sonos.com/control/api/v1/groups/\(groupId)/playback/seek"
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
            "positionMillis": positionMillis
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
