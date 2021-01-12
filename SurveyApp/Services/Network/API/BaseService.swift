//
//  BaseService.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 12/1/2564 BE.
//

import Foundation
import Alamofire
import SwiftyJSON

class BaseService: NSObject {

    func callWebServiceAlamofire(_ alamoReq: AlamofireRequestModal, success: @escaping ((_ responseObject: AnyObject?) -> Void), failure: @escaping ((_ error: NSError?) -> Void)) {

        let req = AF.request(alamoReq.path, method: alamoReq.method, parameters: alamoReq.parameters, encoding: alamoReq.encoding, headers: alamoReq.headers)

        req.validate(statusCode: 200..<600).responseJSON(completionHandler: { response in
            let statusCode = response.response?.statusCode

            switch response.result {
            case .success(let data):

                if statusCode == 200 {
                    success(data as AnyObject?)
                } else if statusCode == 401 {
                    // Unauthorized or access token expire
                    self.requestForRefreshToken(alaomReq: alamoReq, success: success, failure: failure)
                }
            case .failure(let error):
                failure(error as NSError?)
            }
        })
    }

}

extension BaseService {
    
    func getAccessToken() -> String {
        if let accessToken =  UserDefaults.standard.string(forKey: "access_token") {
            return "Bearer " + accessToken
        } else {
            return ""
        }
    }

    // MARK: - API CALL
    func requestForRefreshToken(alaomReq: AlamofireRequestModal, success: @escaping ((_ responseObject: AnyObject?) -> Void), failure: @escaping ((_ error: NSError?) -> Void) ) {
        
        let client_id = ProcessInfo.processInfo.environment["client_id"]!
        let client_secret = ProcessInfo.processInfo.environment["client_secret"]!
        let refreshToken = UserDefaults.standard.string(forKey: "refresh_token")
        
        let reqBody = [
            "grant_type": "refresh_token",
            "refresh_token": refreshToken,
            "client_id": client_id,
            "client_secret": client_secret
        ]
        
        AF.request(URL_LOGIN, method: .post, parameters: reqBody as Parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let userTokenType = json["data"]["attributes"]["token_type"].stringValue
                let accessToken = json["data"]["attributes"]["access_token"].stringValue
                let refreshToken = json["data"]["attributes"]["refresh_token"].stringValue
                UserDefaults.standard.setValue(userTokenType, forKeyPath: "user_token_type")
                UserDefaults.standard.setValue(accessToken, forKeyPath: "access_token")
                UserDefaults.standard.setValue(refreshToken, forKeyPath: "refresh_token")
            case .failure(let error):
                debugPrint(error)
            }
        }
        
        var request: AlamofireRequestModal = alaomReq
        request.headers = ["Authorization": self.getAccessToken()]
        
        self.callWebServiceAlamofire(request, success: success, failure: failure)
    }

}
