//
//  File.swift
//  
//
//  Created by James Hickman on 2/9/21.
//

import Foundation
import Alamofire

protocol Networking {
    
    /// The HTTP method to be used for the request.
    func HTTPMethod() -> HTTPMethod
    
    /// The ParameterEncoding to be used for the request.
    func encoding() -> ParameterEncoding
    
    /// The URL to be used for the request.
    func preparedURL() -> URLConvertible
    
    /// The headers to be used for the request.
    func headers() -> HTTPHeaders?
    
    /// The parameters to be used for the request.
    func parameters() -> Parameters?
    
    /// The function to perform the request using Alamofire's `request(...)` function.
    func performRequest()
    
    /// The success callback to be used for the request.
    func success(_: Data?)
    
    /// The failure callback to be used for the request.
    func failure(_: Error?)
    
}

public class Network: Networking {
    
    // MARK: - Public
    
    public func performRequest() {
        let weakSelf = self
        session.request(preparedURL(),
                        method: HTTPMethod(),
                        parameters: parameters(),
                        encoding: encoding(),
                        headers: headers()).responseJSON { response in
                            switch response.result {
                            case .success:
                                weakSelf.success(response.data)
                            case let .failure(error):
                                weakSelf.failure(error)
                            }
                        }
    }

    // MARK: - Internal
    
    /// The Alamofire session which can be configured by the caller for custom requirements.
    var session: Session = Alamofire.Session()
    
    // MARK: - Networking
    
    func HTTPMethod() -> HTTPMethod {
        return .get
    }
    
    func encoding() -> ParameterEncoding {
        return URLEncoding.default
    }
    
    func preparedURL() -> URLConvertible {
        return ""
    }
    
    func headers() -> HTTPHeaders? {
        return nil
    }
    
    func parameters() -> Parameters? {
        return nil
    }
        
    func success(_ data: Data?) { }
    
    func failure(_ error: Error?) { }
    
}
