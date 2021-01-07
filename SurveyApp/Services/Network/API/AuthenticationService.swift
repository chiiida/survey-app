//
//  AuthenticationService.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 6/1/2564 BE.
//

import Foundation
import Alamofire

class AuthenticationService {
    
    static let instance = AuthenticationService()
    
//    private var header: HTTPHeaders = [
//        "X-Mashape-Key": MY_API_KEY,
//        "Accept": "application/json"
//      ]
    
    func login(email: String, password: String, completion: @escaping () -> Void) {
        let client_id = ProcessInfo.processInfo.environment["client_id"]!
        let client_secret = ProcessInfo.processInfo.environment["client_secret"]!
        
        print(client_id)
        
        let loginRequest =  LoginRequest(grant_type: "password", email: email, password: password, client_id: client_id, client_secret: client_secret)
        
        AF.request(URL_LOGIN, method: .post, parameters: loginRequest.toDictonary(), encoding: JSONEncoding.default).responseJSON { (response) in
            print(response)
        }
    }
    
}
