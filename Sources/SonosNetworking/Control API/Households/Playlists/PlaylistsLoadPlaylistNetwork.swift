//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaylistsLoadPlaylistNetwork is used to activate a playlist within the default playback session. This command interrupts any active private playback sessions. Sonos adds tracks from the playlist to the queue and activates the queue. This prevents your app from overwriting user-curated queues.
public class PlaylistsLoadPlaylistNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var groupId: String
    private var action: String?
    private var playlistId: String
    private var playOnCompletion: Bool?
    private var playModes: [String]?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaylistsLoadPlaylistNetwork to activate a playlist within the default playback session.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - groupId: This command requires a groupId to determine the target of the command.
    ///   - action: Controls how the the player inserts the playlist into the shared queue, such as append, insert, insert next, or replace. If omitted, defaults to append.
    ///   - playlistId: The identifier of the playlist. You can find this in the playlistsList object in the getPlaylists response.
    ///   - playOnCompletion: If true, the player automatically starts playback. If false or not provided, the player remains in the PLAYBACK_IDLE state.
    ///   - playModes: Defines the functionality of one or more play modes. You can set these to customize shuffle, repeat, repeat-one and crossfade.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                groupId: String,
                action: String? = nil,
                playlistId: String,
                playOnCompletion: Bool? = nil,
                playModes: [String]? = nil,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.groupId = groupId
        self.action = action
        self.playlistId = playlistId
        self.playOnCompletion = playOnCompletion
        self.playModes = playModes
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
        return "https://api.ws.sonos.com/control/api/v1/groups/\(groupId)/playlists"
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
            "playlistId": playlistId
        ]

        if let action = action {
            parameters["action"] = action
        }
        if let playOnCompletion = playOnCompletion {
            parameters["playOnCompletion"] = playOnCompletion
        }
        if let playModes = playModes {
            parameters["playModes"] = playModes
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
