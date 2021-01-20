//
//  AuthenticationService.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 6/1/2564 BE.
//

import Foundation
import Alamofire

class AuthenticationService: BaseService {
    
    static let instance = AuthenticationService()
    let client_id = ProcessInfo.processInfo.environment["client_id"]!
    let client_secret = ProcessInfo.processInfo.environment["client_secret"]!
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        let loginRequest =  LoginRequest(grant_type: "password", email: email, password: password, client_id: self.client_id, client_secret: self.client_secret)
        
        AF.request(URL_LOGIN, method: .post, parameters: loginRequest.toDictonary(), encoding: JSONEncoding.default).responseDecodable(of: AuthResponse.self) { (response) in
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success:
                    if statusCode == 200 {
                        guard let user = response.value else { return }
                        let userTokenType = user.data.attributes.token_type
                        let accessToken = user.data.attributes.access_token
                        let refreshToken = user.data.attributes.refresh_token
                        UserDefaults.standard.setValue(userTokenType, forKeyPath: "user_token_type")
                        UserDefaults.standard.setValue(accessToken, forKeyPath: "access_token")
                        UserDefaults.standard.setValue(refreshToken, forKeyPath: "refresh_token")
                        completion(true)
                    }
                case .failure(let error):
                    completion(false)
                    debugPrint(error)
                }
                
            }
    }
    
    func logOut(completion: @escaping (Bool) -> Void) {
        let access_token = UserDefaults.standard.string(forKey: "access_token")
        let reqBody: Parameters = [
            "token": access_token!,
            "client_id": self.client_id,
            "client_secret": self.client_secret
        ]
        
        AF.request(URL_LOGIN, method: .post, parameters: reqBody as Parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success( _):
                UserDefaults.standard.setValue(nil, forKeyPath: "user_token_type")
                UserDefaults.standard.setValue(nil, forKeyPath: "access_token")
                UserDefaults.standard.setValue(nil, forKeyPath: "refresh_token")
                completion(true)
            case .failure(let error):
                completion(false)
                debugPrint(error)
            }
        }
    }
    
}
