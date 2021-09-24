//
//  File.swift
//  
//
//  Created by James Hickman on 2/22/21.
//

import Foundation
import Alamofire

/// HomeTheaterSetOptionsNetwork is used to set homeTheaterOptions such as nightMode and enhanceDialog. See the homeTheaterOptions type for details.
public class HomeTheaterSetOptionsNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var playerId: String
    private var nightMode: Bool?
    private var enhanceDialog: Bool?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of HomeTheaterSetOptionsNetwork to set homeTheaterOptions such as nightMode and enhanceDialog.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - playerId: This command requires a playerId to determine the target of the command.
    ///   - nightMode: Night mode enhances quiet sounds and reduces the intensity of loud sounds. Turn on to reduce the volume of loud sounds while still experiencing proper balance and range. Set to true to turn on night mode or false to turn it off.
    ///   - enhanceDialog: Speech enhancement boosts the audio frequencies associated with the human voice. Turn on to make dialogue easier to hear. Set to true to turn on speech enhancement or false to turn it off.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                playerId: String,
                nightMode: Bool? = nil,
                enhanceDialog: Bool? = nil,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.playerId = playerId
        self.nightMode = nightMode
        self.enhanceDialog = enhanceDialog
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
        return "https://api.ws.sonos.com/control/api/v1/players/\(playerId)/homeTheater/options"
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

        if let nightMode = nightMode {
            parameters["nightMode"] = nightMode
        }
        if let enhanceDialog = enhanceDialog {
            parameters["enhanceDialog"] = enhanceDialog
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
