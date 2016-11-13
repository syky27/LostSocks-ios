//
//  Router.swift
//  LostSocks
//
//  Created by Tomas Sykora, jr. on 12/11/2016.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case createUser(parameters: Parameters)
    case loginUser(parameters: Parameters)
    case readUser
    case getSocks
    case storeSock(parameters: Parameters)
    
    
    static let baseURLString = "http://lostsocksapi.herokuapp.com"
    
    var method: HTTPMethod {
        switch self {
        case .createUser:
            return .post
        case .loginUser:
            return .post
        case .readUser:
            return .get
        case .getSocks:
            return .get
        case .storeSock:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .createUser:
            return "/register"
        case .loginUser:
            return "/login"
        case .readUser:
            return "/api/me"
        case .getSocks:
            return "/socks"
        case .storeSock:
            return "/socks"
    
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        var headers: HTTPHeaders = [:]
        
        if let apiID = UserDefaults.standard.value(forKey: "API_KEY_ID"),
            let apiSecreat = UserDefaults.standard.value(forKey: "API_KEY_SECREAT") {
            if let authorizationHeader = Request.authorizationHeader(user: String(describing: apiID), password: String(describing: apiSecreat)) {
                headers[authorizationHeader.key] = authorizationHeader.value
            }
        }
        
        
        
        urlRequest.allHTTPHeaderFields = headers
        
        switch self {
        case .createUser(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .loginUser(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .storeSock(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            
        default:
            break
        }
        
        
        return urlRequest
    }
}
