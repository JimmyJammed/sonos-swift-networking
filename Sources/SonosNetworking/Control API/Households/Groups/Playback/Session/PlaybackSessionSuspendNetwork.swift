//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackSessionSuspendNetwork is used to suspend a specified session. The player will clear the stored item window of tracks and send a playbackStatus event to tell clients that the current item is null.
/// As described in a cloud queue use case in Play audio, if your app sends a play command when the cloud queue is empty, the player will attempt to resume playback of content that was playing prior to this command. For example, if the user was previously listening to a radio station or had a playlist queued, it will attempt to resume playback of that content.
/// When a session is suspended, the player won’t revert to the previous music source in this case. Instead, the player delivers a sessionInfo event with a suspended value of true for the suspended session.
public class PlaybackSessionSuspendNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var sessionId: String
    private var queueVersion: String?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackSessionSuspendNetwork to suspend a specified session.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - sessionId: This command requires a sessionId to determine the target of the command.
    ///   - queueVersion: The player will store this value locally. The cloud queue server should return this queue version in all GET /version and GET /itemWindow responses while the player is suspended.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                sessionId: String,
                queueVersion: String? = nil,
                success: @escaping (Data?) -> Void, failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.sessionId = sessionId
        self.queueVersion = queueVersion
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
        return "https://api.ws.sonos.com/control/api/v1/playbackSessions/\(sessionId)/playbackSession/suspend"
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
        var parameters: [String: Any] = [:]
        
        if let queueVersion = queueVersion {
            parameters["queueVersion"] = queueVersion
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
