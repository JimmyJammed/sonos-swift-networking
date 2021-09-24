//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackSkipToNextTrackNetwork is used to skip to the next track.
/// Not all audio sources allow multiple tracks. For example, when a group is streaming an Internet radio station, there is no next track to skip to. If you send a skipToNextTrack command when the audio source does not support multiple tracks, your app will receive an ERROR_PLAYBACK_FAILED, but the audio will continue playing.
public class PlaybackSkipToNextTrackNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var groupId: String
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackSkipToNextTrackNetwork for skipping the next track.
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
    
    override func HTTPMethod() -> HTTPMethod {
        return .post
    }

    override func encoding() -> ParameterEncoding {
        return JSONEncoding.default
    }
    
    override func preparedURL() -> URLConvertible {
        return "https://api.ws.sonos.com/control/api/v1/groups/\(groupId)/playback/skipToNextTrack"
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
