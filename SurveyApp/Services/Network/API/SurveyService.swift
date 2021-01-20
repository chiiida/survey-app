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
            request.encoding = JSONEncoding.default
        
        self.callWebServiceAlamofire(request, decodableModel: SurveyResponse.self, success: { (response) in
            guard let surveyResponse = response as? SurveyResponse else { return }
            for item in surveyResponse.data {
                let id = item.id
                let title = item.attributes.title
                let desctiption = item.attributes.description
                let url = "\(item.attributes.cover_image_url)l"

                let survey = Survey(id: id, title: title, description: desctiption, cover_image_url: url)
                surveys.append(survey)
            }
            completion(surveys)
        }, failure: { error in
            debugPrint(error!)
        })
    }
    
}
