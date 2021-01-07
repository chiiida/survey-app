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
        let loginRequest =  LoginRequest(grant_type: "password", email: email, password: password, client_id: "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE", client_secret: "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU")
        AF.request(URL_LOGIN, method: .post, parameters: loginRequest.toDictonary(), encoding: JSONEncoding.default).responseJSON { (response) in
            print(response)
        }
    }
    
}
