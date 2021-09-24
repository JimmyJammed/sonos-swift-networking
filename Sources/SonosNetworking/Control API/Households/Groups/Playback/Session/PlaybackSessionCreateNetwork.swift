//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackSessionCreateNetwork is used to unconditionally create a new session and clobber any existing sessions.
/// Use appContext to determine how multiple instances of your app can share control of a session. For example, if you provide a user account identifier as appContext, then two instances of your app logged into the same user account would be able to control the same session on a group. If you choose to implement your app to always provide an appContext that is unique for all app instances, then only one app instance can control a session at any time.
/// Use customData to save information in the session that your app finds useful. For example, your app could store a playlist identifier in customData, so that another app instance could automatically load the right playlist when joining a session.
public class PlaybackSessionCreateNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var groupId: String
    private var accountId: String?
    private var appContext: String
    private var appId: String
    private var customData: String?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackSessionCreateNetwork for creating a new session and clobbering any existing session.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - groupId: This command requires a groupId to determine the target of the command.
    ///   - accountId: The music service account to use on Sonos for playback in the session. See the MusicObjectId for more details about this parameter. If your app submits an invalid accountId, you will receive an ERROR_INVALID_PARAMETER error. An accountId is invalid when it doesn’t match a stored account on the player.
    ///   - appContext: Instance data for your app, an opaque string that you can use to identify a particular user account, for example. It is used together with appId to determine if a session can be joined or not. As a best practice, user-identifiable data should be hashed or encoded so that it is only useful to your app. The sum total length of appId and appContext must be less than 255 bytes. Otherwise, the player will return an error.
    ///   - appId: Identifies your app. This should be a reverse DNS name of the form “com.companyname.appname” or similar. It is used together with appContext to determine if a session can be joined or not. As a best practice, user-identifiable data should be hashed or encoded so that it is only useful to your app. The sum total length of appId and appContext must be less than 255 bytes. Otherwise, the player will return an error.
    ///   - customData: A blob of text stored by the player and passed back to any other clients that successfully join an existing session. This data (up to 1023 bytes) is stored within the session. The player truncates blobs of text that are longer than 1023 bytes and returns the truncated string in the command response. The default value is an empty string (“”). As a best practice, user-identifiable data should be hashed or encoded so that it is only useful to your app.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                groupId: String,
                accountId: String?,
                appContext: String,
                appId: String,
                customData: String?,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.groupId = groupId
        self.accountId = accountId
        self.appContext = appContext
        self.appId = appId
        self.customData = customData
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
        return "https://api.ws.sonos.com/control/api/v1/groups/\(groupId)/playbackSession/create"
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
            "appContext": appContext,
            "appId": appId
        ]

        if let accountId = accountId {
            parameters["accountId"] = accountId
        }
        if let customData = customData {
            parameters["customData"] = customData
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
