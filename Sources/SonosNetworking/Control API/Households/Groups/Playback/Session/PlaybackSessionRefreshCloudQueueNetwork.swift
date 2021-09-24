//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackSessionRefreshCloudQueueNetwork is used to signal the player to re-fetch tracks from the cloud queue server centered around the current item. See the Cloud Queue API /itemWindow endpoint for details.
/// This command requires your app to have either created a new session or joined an existing session, and also loaded a cloud queue on the group with loadCloudQueue.
/// Your app should only use this command when it detects a change in the cloud queue content that should immediately be reflected in the group. For example, if a user removes the currently playing track with your app, use this command to remove the track from the group and stop it from playing. This helps provide a good user experience.
public class PlaybackSessionRefreshCloudQueueNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var sessionId: String
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackSessionRefreshCloudQueueNetwork re-fetching tracks from the cloud queue server.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - sessionId: This command requires a sessionId to determine the target of the command.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                sessionId: String,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.sessionId = sessionId
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
        return "https://api.ws.sonos.com/control/api/v1/playbackSessions/\(sessionId)/playbackSession/refreshCloudQueue"
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
