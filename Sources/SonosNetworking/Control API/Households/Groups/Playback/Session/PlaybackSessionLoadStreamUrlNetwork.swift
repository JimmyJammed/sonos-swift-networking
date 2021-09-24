//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackSessionLoadStreamUrlNetwork is used to load a streaming (live) radio station URL and optionally start playback. Upon successful completion, the player sends a playbackStatus event to your app or hardware integration. Your app should subscribe to the playback namespace before sending the loadStreamUrl command to avoid race conditions in receiving playbackStatus or playbackError events.
/// This command requires that your app has an open playback session with a cloud queue, created or joined using the createSession, joinSession, or joinOrCreateSession command.
/// If you want to immediately start playing the stream, set the playOnCompletion parameter to true. This bypasses the need to send a play command after the player loads the stream.
public class PlaybackSessionLoadStreamUrlNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var sessionId: String
    private var itemId: String?
    private var streamUrl: String
    private var playOnCompletion: Bool?
    private var stationMetadata: [String: Any]?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackSessionLoadStreamUrlNetwork for loading a streaming (live) radio station URL.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - sessionId: This command requires a sessionId to determine the target of the command.
    ///   - itemId: If provided, the player includes this itemId in subsequent playbackStatus and playbackError events corresponding to this stream.
    ///   - streamUrl: HTTP URL for the radio station stream. See the supported content types below. Note that you cannot use this command to send an on-demand track for playback.
    ///   - playOnCompletion: If true, the player will start playback after loading the stream URL. If false or not provided, the player remains in the PLAYBACK_IDLE state.
    ///   - stationMetadata: Metadata about the radio station. See below for details.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                sessionId: String,
                itemId: String? = nil,
                streamUrl: String,
                playOnCompletion: Bool? = nil,
                stationMetadata: [String: Any]? = nil,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.sessionId = sessionId
        self.itemId = itemId
        self.streamUrl = streamUrl
        self.playOnCompletion = playOnCompletion
        self.stationMetadata = stationMetadata
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
        return "https://api.ws.sonos.com/control/api/v1/playbackSessions/\(sessionId)/playbackSession/loadStreamUrl"
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
            "streamUrl": streamUrl
        ]

        if let itemId = itemId {
            parameters["itemId"] = itemId
        }
        if let playOnCompletion = playOnCompletion {
            parameters["playOnCompletion"] = playOnCompletion
        }
        if let stationMetadata = stationMetadata {
            parameters["stationMetadata"] = stationMetadata
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
