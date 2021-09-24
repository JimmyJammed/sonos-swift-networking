//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackSessionSeekNetwork is used to seek to the position in the track with the specified itemId in a cloud queue. This command requires your app to have either created a new session or joined an existing session, and also loaded a cloud queue on the group with loadCloudQueue.
/// Use itemId to ensure the group seeks on the current item. If the current item’s itemId does not match the one provided, the player returns an ERROR_INVALID_OBJECT_ID error.
public class PlaybackSessionSeekNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var sessionId: String
    private var itemId: String
    private var positionMillis: UInt
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackSessionSeekNetwork to seek to the position in the track with the specified itemId in a cloud queue.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - sessionId: This command requires a sessionId to determine the target of the command.
    ///   - itemId: The identifier for the item. If this parameter does not match the currently playing item, the command fails. This ensures that playback does not jump back to a track if a user starts to scrub just as the player begins to play the next item.
    ///   - positionMillis: Position within track in milliseconds. If this value exceeds the current track duration time, Sonos moves to the end of the current track, which results in a skip to the next track.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                sessionId: String,
                itemId: String,
                positionMillis: UInt,
                success: @escaping (Data?) -> Void, failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.sessionId = sessionId
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
        return "https://api.ws.sonos.com/control/api/v1/playbackSessions/\(sessionId)/playbackSession/seek"
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
            "itemId": itemId,
            "positionMillis": positionMillis
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
