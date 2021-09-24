//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackLoadLineInNetwork is used to change the current group source to the line-in source of a specified player. This can be be any player in the household that supports line-in. See Using Line-In on Sonos on the Sonos Support site for more details about the line-in capabilities of our players.
/// You can tell whether a player has line-in capabilities with the LINE_IN value in the capabilities object. 
/// The player will switch away from the line-in source when the hardware detects that the user has physically unplugged the line-in cable.
public class PlaybackLoadLineInNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var groupId: String
    private var deviceId: String?
    private var playOnCompletion: Bool?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackLoadLineInNetwork for changing the line-in source.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - groupId: This command requires a groupId to determine the target of the command.
    ///   - deviceId: Represents the line-in source, any player in the household that supports line-in. The default value is the local deviceId. This is the same as the player ID returned in the player object.
    ///   - playOnCompletion: If true, start playback after loading the line-in source. If false, the player loads the cloud queue, but requires the play command to begin. If not provided, the default value is false.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                groupId: String,
                deviceId: String? = nil,
                playOnCompletion: Bool? = nil,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.groupId = groupId
        self.deviceId = deviceId
        self.playOnCompletion = playOnCompletion
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
        return "https://api.ws.sonos.com/control/api/v1/groups/\(groupId)/playback/lineIn"
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
        
        if let deviceId = deviceId {
            parameters["deviceId"] = deviceId
        }
        if let playOnCompletion = playOnCompletion {
            parameters["playOnCompletion"] = playOnCompletion
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
