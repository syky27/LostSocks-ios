//
//  APIWrapper.swift
//  LostSocks
//
//  Created by Tomas Sykora, jr. on 12/11/2016.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import Foundation
import Alamofire

class APIWrapper: NSObject {
    
    class func registerUser(username: String, password: String, completionHandler:@escaping (Bool) -> ()) {
        Alamofire.request(Router.createUser(parameters: ["username": username, "password" : password]))
        .validate()
        .responseJSON { json in
            print(json)
        }
    }
    
    class func loginUser(username: String, password: String, completionHandler:@escaping (Bool) -> ()) {
        Alamofire.request(Router.loginUser(parameters: ["username": username, "password" : password]))
            .validate()
            .responseJSON { response in
                print(response)
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    UserDefaults.standard.set(JSON["api_key_id"], forKey: "API_KEY_ID")
                    UserDefaults.standard.set(JSON["api_key_secret"], forKey: "API_KEY_SECRET")
                    
                    completionHandler(true)
                }
        }
    }
    
    class func getMe() {
        Alamofire.request(Router.readUser)
        .validate()
        .responseJSON { json in
            print(json)
        }
    }
    
    class func getSocks(completionHandler:@escaping ([Sock]) -> ()) {
        Alamofire.request(Router.getSocks)
        .validate()
        .responseJSON { (response) in
            switch response.result {
                case .success:
                    if let result = response.result.value {
                        let JSON = result as! [Dictionary<String, Any>]
                        var socks = [Sock]()
                        for partial in JSON {
                            socks.append(Sock(node: partial))
                        }
                        print(socks)
                        completionHandler(socks)
                    }
                break
                case .failure:
                break
            }
            
        }
    }
    
    class func storeSock(_ sock: Sock, completionHandler: @escaping (Sock) -> ()) {
        Alamofire.request(Router.storeSock(parameters: sock.json()))
        .validate()
        .responseJSON { (response) in
            switch response.result {
            case .success(let json):
                print(json)
                break
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
