//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackSessionSkipToItemNetwork is used to skip to the track with the specified itemId in a cloud queue and optionally seek and initiate playback. This command requires your app to have either created a new session or joined an existing session, and also loaded a cloud queue on the group with loadCloudQueue.
/// Use playOnCompletion to start playing the cloud queue item being loaded, so your app doesn’t have to send an extra play command.
/// Most of the times your app already has access to the track metadata of the cloud queue item that is being loaded. Use the optional trackMetadata parameter to provide that information so the group can start playing the track immediately after receiving the loadCloudQueue command. This optimization improves the user experience by starting playback before the player fetches tracks from the cloud queue server.
public class PlaybackSessionSkipToItemNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var sessionId: String
    private var itemId: String
    private var playOnCompletion: Bool?
    private var positionMillis: UInt?
    private var queueVersion: String?
    private var trackMetadata: [String: Any]?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackSessionSkipToItemNetwork to  skip to the track with the specified itemId in a cloud queue and optionally seek and initiate playback.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - sessionId: This command requires a sessionId to determine the target of the command.
    ///   - itemId: The identifier for the track. This is required, but does not need to be a value. If it is an empty string, the group will skip to the beginning of the queue.
    ///   - playOnCompletion: Start playback after loading.
    ///   - positionMillis: Position within track in milliseconds. If you omit this parameter and send a different itemId than the one that is currently playing, the player assumes that the positionMillis is zero. If you omit this parameter and send the itemId that is currently playing, the player does not change the position, and continues playing.
    ///   - queueVersion: An opaque identifier used to indicate the change state of the contents in the cloud queue. For example, if the list of tracks in the cloud queue change, the cloud queue server would change the queueVersion. The player stores this value and can pass it back in the GET /itemWindow request.
    ///   - trackMetadata: The target track to play. Entering this value enables the player to load and start playing the track immediately. See the track playback object for the data structure of this object.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                sessionId: String,
                itemId: String,
                playOnCompletion: Bool? = nil,
                positionMillis: UInt? = nil,
                queueVersion: String? = nil,
                trackMetadata: [String: Any]? = nil,
                success: @escaping (Data?) -> Void, failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.sessionId = sessionId
        self.itemId = itemId
        self.playOnCompletion = playOnCompletion
        self.positionMillis = positionMillis
        self.queueVersion = queueVersion
        self.trackMetadata = trackMetadata
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
        return "https://api.ws.sonos.com/control/api/v1/playbackSessions/\(sessionId)/playbackSession/skipToItem"
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
            "itemId": itemId
        ]
        
        if let playOnCompletion = playOnCompletion {
            parameters["playOnCompletion"] = playOnCompletion
        }
        if let positionMillis = positionMillis {
            parameters["positionMillis"] = positionMillis
        }
        if let queueVersion = queueVersion {
            parameters["queueVersion"] = queueVersion
        }
        if let trackMetadata = trackMetadata {
            parameters["trackMetadata"] = trackMetadata
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
