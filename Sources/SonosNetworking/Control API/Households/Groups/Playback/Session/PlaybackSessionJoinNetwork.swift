//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// PlaybackSessionJoinNetwork is used to join an existing session in the group. To successfully join the session your app will have to provide the same appId and appContext that was used when creating the session.
public class PlaybackSessionJoinNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var groupId: String
    private var appId: String
    private var appContext: String
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of PlaybackSessionJoinNetwork for joining an existing session in the group.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - groupId: This command requires a groupId to determine the target of the command.
    ///   - appId: Identifies your app. This should be a reverse DNS name of the form “com.companyname.appname” or similar. It is used together with appContext to determine if a session can be joined or not. As a best practice, user-identifiable data should be hashed or encoded so that it is only useful to your app. The sum total length of appId and appContext must be less than 255 bytes. Otherwise, the player will return an error.
    ///   - appContext: Instance data for your app, an opaque string that you can use to identify a particular user account, for example. It is used together with appId to determine if a session can be joined or not. As a best practice, user-identifiable data should be hashed or encoded so that it is only useful to your app. The sum total length of appId and appContext must be less than 255 bytes. Otherwise, the player will return an error.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                groupId: String,
                appId: String,
                appContext: String,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.groupId = groupId
        self.appId = appId
        self.appContext = appContext
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
        return "https://api.ws.sonos.com/control/api/v1/groups/\(groupId)/playbackSession/join"
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
            "appId": appId,
            "appContext": appContext
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
