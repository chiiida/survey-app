//
//  SurveyService.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 10/1/2564 BE.
//

import Foundation
import Alamofire
import SwiftyJSON

class SurveyService {
    
    static let instance = SurveyService()
    
    func fetchSurveys(completion: @escaping ([Survey]) -> Void) {
        var surveys = [Survey]()
        AF.request("http://127.0.0.1:5000/api/temp/surveys", method: .get, parameters: nil,
                   encoding: JSONEncoding.default).responseJSON { (response) in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
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
                    case .failure(let error):
                        debugPrint(error)
                    }
                    completion(surveys)
        }
    }
    
}
