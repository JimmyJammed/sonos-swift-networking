//
//  File.swift
//  
//
//  Created by James Hickman on 2/23/21.
//

import Foundation
import Alamofire

/// AudioClipLoadNetwork is used to schedule an audio clip for playback. The command returns immediately, indicating whether the audio clip was successfully scheduled or not.
/// The player can handle multiple audio clips and implements a simple priority system to determine playback order.
public class AudioClipLoadNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var playerId: String
    private var appId: String
    private var clipType: String?
    private var httpAuthorization: String?
    private var name: String
    private var priority: String?
    private var streamUrl: String?
    private var volume: Int?

    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of AudioClipLoadNetwork to schedule an audio clip for playback.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - playerId: This command requires a playerId to determine the target of the command.
    ///   - appId: This string identifies the app that created the audioClip. Companies should use their reversed Internet domain name as the identifier, similar to com.acme.app.
    ///   - clipType: Sonos plays a built-in sound when you send this parameter. The default value is CHIME.
    ///   - httpAuthorization: Set a string to pass in the Authorization header when fetching the streamUrl. Omit this parameter to omit the Authorization header. Sonos includes the Authorization header when the streamUrl is secure (HTTPS). Sonos supports an httpAuthorization value up to 512 bytes.
    ///   - name: User identifiable string.
    ///   - priority: Clip priority. Clips are low priority by default.
    ///   - streamUrl: Sonos will play this URL when you provide one. The caller does not need to specify a CUSTOM clipType in addition to providing the streamUrl. Sonos supports only MP3 or WAV files as audio clips.
    ///   - volume: Audio Clip playback volume, between 0 and 100. There are internal upper and lower limits for the audio clip volume level in order to prevent the audio clip from being too loud or inaudible. If the parameter is beyond those limits, Sonos automatically adjusts the audio clip volume to the lower or upper limit. The default behavior is to playback at the current player volume.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                playerId: String,
                appId: String,
                clipType: String?,
                httpAuthorization: String?,
                name: String,
                priority: String?,
                streamUrl: String?,
                volume: Int?,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.playerId = playerId
        self.appId = appId
        self.clipType = clipType
        self.httpAuthorization = httpAuthorization
        self.name = name
        self.priority = priority
        self.streamUrl = streamUrl
        self.volume = volume
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
        return "https://api.ws.sonos.com/control/api/v1/players/\(playerId)/audioClip"
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
        parameters["appId"] = appId
        parameters["name"] = name

        if let clipType = clipType {
            parameters["clipType"] = clipType
        }
        if let httpAuthorization = httpAuthorization {
            parameters["httpAuthorization"] = httpAuthorization
        }
        if let priority = priority {
            parameters["priority"] = priority
        }
        if let streamUrl = streamUrl {
            parameters["streamUrl"] = streamUrl
        }
        if let volume = volume {
            parameters["volume"] = volume
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
