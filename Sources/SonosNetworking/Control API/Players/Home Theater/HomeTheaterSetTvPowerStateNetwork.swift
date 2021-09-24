//
//  File.swift
//
//
//  Created by James Hickman on 2/22/21.
//

import Foundation
import Alamofire

/// HomeTheaterSetTvPowerStateNetwork is used if the HDMI CEC bus is available, will instruct the home theater capable device to send a CEC “TV On” command on the bus. The CEC specification does not require that the device acknowledges commands. Support for this command varies by TV manufacturer. If the TV sends a success or failure response to the player, the player provides it to your integration. Otherwise, the player returns a generic success response.
/// Note that this command is only applicable for Sonos players that support HDMI ARC. Currently this is only the Beam. If your integration sends this command to a player that doesn’t support it, the player returns a globalError with an errorCode
public class HomeTheaterSetTvPowerStateNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var playerId: String
    private var tvPowerState: String
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of HomeTheaterSetTvPowerStateNetwork will instruct the home theater capable device to send a CEC “TV On” command on the bus.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - playerId: This command requires a playerId to determine the target of the command.
    ///   - tvPowerState: The TV Power State control options.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                playerId: String,
                tvPowerState: String,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.playerId = playerId
        self.tvPowerState = tvPowerState
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
        return "https://api.ws.sonos.com/control/api/v1/players/\(playerId)/homeTheater/tvPowerState"
    }

    override func headers() -> HTTPHeaders? {
        let headers = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)")
        ]

        return HTTPHeaders(headers)
    }
        
    override func parameters() -> Parameters? {
        let parameters: [String: Any] = [
            "tvPowerState": tvPowerState
        ]
        
        return parameters
    }
    
    override func success(_ data: Data?) {
        successHandler(data)
    }
    
    override func failure(_ error: Error?) {
        failureHandler(error)
    }
    
}
