//
//  File.swift
//
//
//  Created by James Hickman on 2/24/21.
//

import Foundation
import Alamofire

/// FavoritesLoadNetwork activates a favorite within the default playback session. This command interrupts any active private playback sessions. Sonos adds album, tracklist, and track favorites to the queue and activates the queue. This prevents your app from overwriting user-curated queues.
public class FavoritesLoadNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var groupId: String
    private var action: String?
    private var favoriteId: String
    private var playOnCompletion: Bool?
    private var playModes: [String]?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of FavoritesLoadNetwork for loading the household's favorites.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - groupId: The group for which to load favorites.
    ///   - action: Controls how the the player inserts the favorite into the shared queue, such as append, insert, insert next, or replace. Not used when the favorite is a radio station (programmed or streamed). If omitted, defaults to append.
    ///   - favoriteId: The identifier of the favorite. You can find this in the favoriteList object in the getFavorites response.
    ///   - playOnCompletion: If true, the player automatically starts playback. If false or not provided, the player remains in the PLAYBACK_IDLE state.
    ///   - playModes: Defines the functionality of one or more play modes. You can set these to customize shuffle, repeat, repeat-one and crossfade. The player ignores this parameter when the loaded favorite does not allow custom play modes, such as for streaming radio stations.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                groupId: String,
                action: String? = nil,
                favoriteId: String,
                playOnCompletion: Bool? = nil,
                playModes: [String]? = nil,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.groupId = groupId
        self.action = action
        self.favoriteId = favoriteId
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
        return "https://api.ws.sonos.com/control/api/v1/groups/\(groupId)/favorites"
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
        var parameters: [String: Any] = ["favoriteId": favoriteId]

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
