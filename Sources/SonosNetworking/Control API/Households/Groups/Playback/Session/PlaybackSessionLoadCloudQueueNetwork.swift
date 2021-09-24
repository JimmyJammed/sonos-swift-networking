//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackSessionLoadCloudQueueNetwork is used to play audio on Sonos by using a cloud queue, a list of tracks that you host on a server that the player can access. See Play audio for details. Use the loadCloudQueue command in the playbackSession namespace to load, and optionally start playback of, an item in a cloud queue.
/// This command requires that your app has an open playback session with a cloud queue, created or joined using the createSession, joinSession, or joinOrCreateSession command.
/// If you want to immediately start playing the track, set the playOnCompletion parameter to true. This bypasses the need to send a play command after the player loads the track. You should also send playback objects with information about the track in the trackMetadata parameter. This optimization improves the user experience by starting playback for the first track before the player fetches tracks from the cloud queue server.
/// After receiving the loadCloudQueue command, the player will fetch a window of tracks from the cloud queue server centered around the item with the itemId that your app provided. If the track was deleted, the group will play the next track in the queue. For more details, see the Cloud Queue API /itemWindow endpoint.
/// All commands in the playback and playbackMetadata namespace also apply to the cloud queue playback. For example, you can send the play or pause command in the playback namespace to play or pause a cloud queue track on a player.
public class PlaybackSessionLoadCloudQueueNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var sessionId: String
    private var httpAuthorization: String?
    private var itemId: String?
    private var playOnCompletion: Bool?
    private var positionMillis: UInt?
    private var queueBaseUrl: String
    private var queueVersion: String?
    private var trackMetadata: [String: Any]?
    private var useHttpAuthorizationForMedia: Bool?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackSessionLoadCloudQueueNetwork for playing audio on Sonos by using a cloud queue.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - sessionId: This command requires a sessionId to determine the target of the command.
    ///   - httpAuthorization: The string value for the HTTP Authorization header, provided to the cloud queue server on all requests. The maximum value is 5120 bytes. See the Authorization for media and the cloud queue section in Play audio for details. If you don’t include this value and the player matches the session to a SMAPI user account, the Authorization header will contain the SMAPI account OAuth token.
    ///   - itemId: The identifier for the track to load. If this is an empty string (“”) or omitted, the player skips to the beginning of the cloud queue by requesting an item window with an empty string as the itemId. If you provide trackMetadata, you must also provide itemId, even if it is “”.
    ///   - playOnCompletion: If true, start playback after loading the cloud queue. If you provided the  trackMetadata, the player begins playback immediately. If you provided the itemId, the player starts playing once the cloud queue window returns the metadata. If not provided, the default value is false. If false, the player loads the cloud queue, but requires the play command to begin.
    ///   - positionMillis: Position within the track in milliseconds. Default value is 0. If not provided and itemId matches the current item, the player does not interrupt playback or change the current position. The player still respects the playOnCompletion parameter, if provided. This value can be formatted as a JSON string or number.
    ///   - queueBaseUrl: The base URL for the cloud queue. The player uses this to form the REST URLs used to access the cloud queue. This URL is required to end in a recognized version specification indicating the version of the Cloud Queue API supported by the server. See the Cloud queue base URL and API version section in Play audio for details. You can pass RESTful segments within the base URL to identify the user. See the Communicate user identity in the base URL section in Play audio for details.
    ///   - queueVersion: An opaque identifier used to indicate the change state of the contents in the cloud queue. For example, if the list of tracks in the cloud queue changes, the cloud queue server would change the queueVersion. The player stores this value and can pass it back in the GET /itemWindow request. This enables your cloud-based client to keep its app and data model in sync across calls to the player.
    ///   - trackMetadata: The metadata for the first track. If provided, the player starts playing the item immediately, with the default playback policies, before the player retrieves the item window. See the track playback object type for the data structure of this object.
    ///   - useHttpAuthorizationForMedia: If true, the player passes the httpAuthorization token to HTTPS media requests associated with the cloud queue. The player never sends the token to insecure (HTTP) requests. This parameter has no bearing when cloud queue items reference SMAPI objects, in which case, the player sends normal SMAPI headers. The default value is false.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                sessionId: String,
                httpAuthorization: String? = nil,
                itemId: String? = nil,
                playOnCompletion: Bool? = nil,
                positionMillis: UInt? = nil,
                queueBaseUrl: String,
                queueVersion: String? = nil,
                trackMetadata: [String: Any]? = nil,
                useHttpAuthorizationForMedia: Bool? = nil,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.sessionId = sessionId
        self.httpAuthorization = httpAuthorization
        self.itemId = itemId
        self.playOnCompletion = playOnCompletion
        self.positionMillis = positionMillis
        self.queueBaseUrl = queueBaseUrl
        self.queueVersion = queueVersion
        self.trackMetadata = trackMetadata
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
        return "https://api.ws.sonos.com/control/api/v1/playbackSessions/\(sessionId)/playbackSession/loadCloudQueue"
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
            "queueBaseUrl": queueBaseUrl
        ]

        if let httpAuthorization = httpAuthorization {
            parameters["httpAuthorization"] = httpAuthorization
        }
        if let itemId = itemId {
            parameters["itemId"] = itemId
        }
        if let playOnCompletion = playOnCompletion {
            parameters["playOnCompletion"] = playOnCompletion
        }
        if let positionMillis = positionMillis {
            parameters["positionMillis"] = positionMillis
        }
        if let queueVersion = queueVersion {
            parameters["queueVersion"] = queueVersion
        }
        if let trackMetadata = trackMetadata {
            parameters["trackMetadata"] = trackMetadata
        }
        if let useHttpAuthorizationForMedia = useHttpAuthorizationForMedia {
            parameters["useHttpAuthorizationForMedia"] = useHttpAuthorizationForMedia
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
