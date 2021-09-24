//
//  File.swift
//
//
//  Created by James Hickman on 2/20/21.
//

import Foundation
import Alamofire

/// GroupVolumeSetRelativeVolumeNetwork is used to increase or decrease group volume, and unmute the group if muted.
/// Your app can use setRelativeVolume instead of setVolume when the user intent is to increase or decrease the group volume, but not to set the final volume to a particular value. For example, your app should use setRelativeVolume when the user presses hard volume plus/minus buttons on a mobile device.
/// The group will automatically limit the final volume set within the valid range, so your app does not need to worry about that.
public class GroupVolumeSetRelativeVolumeNetwork: Network {
    
    // MARK: - Private Vars
    
    private var accessToken: String
    private var groupId: String
    private var volumeDelta: Int
    private var successHandler: (Data?) -> Void
    private var failureHandler: (Error?) -> Void
    
    // MARK: - Init

    /// Initializes an instance of GroupVolumeSetRelativeVolumeNetwork to increase or decrease group volume, and unmute the group if muted.
    /// - Important: Requires a call to `performRequest()` to make the request.
    /// - Parameters:
    ///   - accessToken: The authentication token.
    ///   - groupId: This command requires a groupId to determine the target of the command.
    ///   - volumeDelta: An integer between -100 and 100 (including those values) indicating the amount to increase or decrease the current group volume. The group coordinator adds this value to the current group volume and then keeps the result in the range of 0 to 100.
    ///   - success: The callback when this request is successful. Response provided as `Data?`.
    ///   - failure: The callback when this request is unsuccessful. Error provided as `Error?`.
    public init(accessToken: String,
                groupId: String,
                volumeDelta: Int,
                success: @escaping (Data?) -> Void,
                failure: @escaping (Error?) -> Void) {
        self.accessToken = accessToken
        self.groupId = groupId
        self.volumeDelta = volumeDelta
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
        return "https://api.ws.sonos.com/control/api/v1/groups/\(groupId)/groupVolume/relative"
    }

    override func headers() -> HTTPHeaders? {
        let headers = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)")
        ]

        return HTTPHeaders(headers)
    }
        
    override func parameters() -> Parameters? {
        let parameters = ["volumeDelta": volumeDelta]
        
        return parameters
    }

    override func success(_ data: Data?) {
        successHandler(data)
    }
    
    override func failure(_ error: Error?) {
        failureHandler(error)
    }

}
