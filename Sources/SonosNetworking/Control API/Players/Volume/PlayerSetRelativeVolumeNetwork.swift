//
//  File.swift
//  
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlayerSetRelativeVolumeNetwork is used to increase or decrease volume for a player and unmute the player if muted.
public class PlayerSetRelativeVolumeNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var playerId: String
    private var volumeDelta: Int
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlayerSetRelativeVolumeNetwork to increase or decrease volume for a player and unmute the player if muted.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - playerId: This command requires a playerId to determine the target of the command.
    ///   - volumeDelta: Between -100 and 100 to indicate the amount to increase or decrease the volume for the player. If your app submits a number outside of this range, you will receive an ERROR_INVALID_PARAMETER error. The player adds this value to the current volume and keeps the result in the range of 0 to 100.
    ///   - muted: true to mute the player or false to unmute the player.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                playerId: String,
                volumeDelta: Int,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.playerId = playerId
        self.volumeDelta = volumeDelta
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
        return "https://api.ws.sonos.com/control/api/v1/players/\(playerId)/playerVolume/relative"
    }

    override func headers() -> HTTPHeaders? {
        let headers = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)")
        ]

        return HTTPHeaders(headers)
    }
    
    override func parameters() -> Parameters? {
        let parameters = ["volumeDelta": volumeDelta]
        
        return parameters
    }
        
    override func success(_ data: Data?) {
        successHandler(data)
    }
    
    override func failure(_ error: Error?) {
        failureHandler(error)
    }

}
