//
//  File.swift
//  
//
//  Created by James Hickman on 2/22/21.
//

import Foundation
import Alamofire

/// PlayerSetSettingsNetwork is used to set volumeMode, volumeScalingFactor, monoMode, and wifiDisable. See the playerSettings type for details.
public class PlayerSetSettingsNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var playerId: String
    private var volumeMode: String?
    private var volumeScalingFactor: Float?
    private var monoMode: Bool?
    private var wifiDisable: Bool?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlayerSetSettingsNetwork to set volumeMode, volumeScalingFactor, monoMode, and wifiDisable. See the playerSettings type for details.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - playerId: This command requires a playerId to determine the target of the command.
    ///   - volumeMode: Set the following values: VARIABLE—the normal mode. The player enables volume controls and makes volume adjustments internally. FIXED—disables volume controls. The player always outputs a fixed volume. This mode is useful for devices without a built-in amplifier, like the Sonos Connect. PASS_THROUGH—enables volume controls in fixed output mode. When enabled, the player emits volume changes as playerVolume events, just as it would in the normal mode. However, the player doesn’t modify the audio signal. This currently works on the Sonos Amp and the Connect. This mode is useful if you offer a third party amp intended for devices without a build-in amplifier, like the Sonos Connect. With this mode, your amp can monitor volume changes from Sonos and automatically adjust the amplifier gain.
    ///   - volumeScalingFactor: A scaling factor between 0.01 (1%) and 1.0 (100%) applied to compute the volume level. When set, this factor applies to each logical player. Only the primary player accepts this value. For example, the left speaker in a bonded pair or the main home theater speaker, such as the Playbar, in a 5.1 surround set. If the value is out of range, you will receive a globalError. If set on a non-primary player, you’ll receive an ERROR_NOT_CAPABLE globalError.
    ///   - monoMode: When true, enables mono mode on supported devices. Currently, only the Sonos Beam supports this setting in a supported setup, with no surrounds. If you set this value on any other product you will receive an ERROR_NOT_CAPABLE globalError with reason “Command not supported on this device.” If you set this value on a Sonos Amp that is not in a supported setup (for example, it has surrounds), you will receive an ERROR_NOT_CAPABLE globalError with reason “Command not supported in current setup.”
    ///   - wifiDisable: When true, disables the wireless radio for the device if it detects a valid Ethernet carrier. If the command fails, the player returns an ERROR_COMMAND_FAILED globalError with a reason indicating either a netstart failure or a lack of Ethernet carrier.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                playerId: String,
                volumeMode: String?,
                volumeScalingFactor: Float?,
                monoMode: Bool?,
                wifiDisable: Bool?,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.playerId = playerId
        self.volumeMode = volumeMode
        self.volumeScalingFactor = volumeScalingFactor
        self.monoMode = monoMode
        self.wifiDisable = wifiDisable
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
        return "https://api.ws.sonos.com/control/api/v1/players/\(playerId)/settings/player"
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
        
        if let volumeMode = volumeMode {
            parameters["volumeMode"] = volumeMode
        }
        if let volumeScalingFactor = volumeScalingFactor, let truncatedValue = Float(String(format: "%.2f", volumeScalingFactor)) {
            parameters["volumeScalingFactor"] = truncatedValue
        }
        if let monoMode = monoMode {
            parameters["monoMode"] = monoMode
        }
        if let wifiDisable = wifiDisable {
            parameters["wifiDisable"] = wifiDisable
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
