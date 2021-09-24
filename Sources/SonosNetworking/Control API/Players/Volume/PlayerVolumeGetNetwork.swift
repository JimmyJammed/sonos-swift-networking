//
//  File.swift
//  
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlayerVolumeGetNetwork is used to get the volume and mute state of a player.
public class PlayerVolumeGetNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var playerId: String
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlayerVolumeGetNetwork to get the volume and mute state of a player.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - playerId: This command requires a playerId to determine the target of the command.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                playerId: String,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.playerId = playerId
        self.successHandler = success
        self.failureHandler = failure
    }
    
    // MARK: - Network
    
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
        
    override func success(_ data: Data?) {
        successHandler(data)
    }
    
    override func failure(_ error: Error?) {
        failureHandler(error)
    }

}
