//
//  SurveyService.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 10/1/2564 BE.
//

import Foundation
import Alamofire
import SwiftyJSON

class SurveyService: BaseService {
    
    static let instance = SurveyService()
    
    var userTokenType = UserDefaults.standard.string(forKey: "user_token_type")
    var accessToken = UserDefaults.standard.string(forKey: "access_token")
    
    func fetchSurveys(completion: @escaping ([Survey]) -> Void) {
        var surveys = [Survey]()
        
        var request: AlamofireRequestModal = AlamofireRequestModal()
            request.method = .get
            request.path = URL_SURVEY_LIST
            request.headers = ["Authorization": getAccessToken()]
        
        self.callWebServiceAlamofire(request, success: { (response) in
            let json = JSON(response!)
            let data = json["data"].arrayValue
            for item in data {
                let id = item["id"].stringValue
                let attributes = item["attributes"]
                let title = attributes["title"].stringValue
                let desctiption = attributes["description"].stringValue
                let url = "\(attributes["cover_image_url"].stringValue)l"

                let survey = Survey(id: id, title: title, description: desctiption, cover_image_url: url)
                surveys.append(survey)
            }
            completion(surveys)
        }, failure: { error in
            debugPrint(error!)
        })
    }
    
}
