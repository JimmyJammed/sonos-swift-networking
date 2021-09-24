//
//  File.swift
//  
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlayerSetVolumeNetwork is used to set player volume and mute state.
public class PlayerSetVolumeNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var playerId: String
    private var volume: Int?
    private var muted: Bool?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlayerSetVolumeNetwork to set player volume and mute state.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - playerId: This command requires a playerId to determine the target of the command.
    ///   - volume: true to mute the player or false to unmute the player.
    ///   - muted: true to mute the player or false to unmute the player.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                playerId: String,
                volume: Int? = nil,
                muted: Bool? = nil,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.playerId = playerId
        self.volume = volume
        self.muted = muted
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
        return "https://api.ws.sonos.com/control/api/v1/players/\(playerId)/playerVolume"
    }

    override func headers() -> HTTPHeaders? {
        let headers = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)")
        ]

        return HTTPHeaders(headers)
    }
    
    override func parameters() -> Parameters? {
        var parameters: [String: Any] = [:]

        if let volume = volume {
            parameters["volume"] = volume
        }
        if let muted = muted {
            parameters["muted"] = muted
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
