//
//  File.swift
//
//
//  Created by James Hickman on 2/22/21.
//

import Foundation
import Alamofire

/// MusicServiceAccountsMatchNetwork is used to get the account ID of a music service user account from the player.
/// All players in the household return the same accounts. Changes made to a player are automatically replicated throughout the household.
/// The createSession and joinOrCreateSession commands in the playbackSession namespace use the account returned by this command to specify the music service account to use for playback during the session. See Account Matching for implementation details.
public class MusicServiceAccountsMatchNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var householdId: String
    private var userIdHashCode: String
    private var nickname: String
    private var serviceId: String
    private var linkCode: String?
    private var linkDeviceId: String?
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of MusicServiceAccountsMatchNetwork to get the account ID of a music service user account from the player.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - householdId: This command requires a householdId to determine the target of the command.
    ///   - userIdHashCode: Opaque hash of the user account. You must use the same algorithm used by your SMAPI server. See getDeviceAuthToken and getUserInfo SMAPI requests for details.
    ///   - nickname: The name for the music service account presented to the user when they view their account from the Sonos app.
    ///   - serviceId: The unique identifier for the music service. Maximum length of 20 characters.
    ///   - linkCode: The link code generated for device authentication. Your SMAPI service can also send this to the player in the getAppLink SMAPI request. The player can send it back in the getDeviceAuthToken SMAPI request.
    ///   - linkDeviceId: Private data associated with the link code to prevent phishing. Like linkCode, also sent in the getAppLink SMAPI request and returned in the getDeviceAuthToken SMAPI request.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                householdId: String,
                userIdHashCode: String,
                nickname: String,
                serviceId: String,
                linkCode: String? = nil,
                linkDeviceId: String? = nil,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.householdId = householdId
        self.userIdHashCode = userIdHashCode
        self.nickname = nickname
        self.serviceId = serviceId
        self.linkCode = linkCode
        self.linkDeviceId = linkDeviceId
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
        return "https://api.ws.sonos.com/control/api/v1/households/\(householdId)/musicServiceAccounts/match"
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
            "userIdHashCode": userIdHashCode,
            "nickname": nickname,
            "serviceId": serviceId
        ]

        if let linkCode = linkCode {
            parameters["linkCode"] = linkCode
        }
        if let linkDeviceId = linkDeviceId {
            parameters["linkDeviceId"] = linkDeviceId
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
