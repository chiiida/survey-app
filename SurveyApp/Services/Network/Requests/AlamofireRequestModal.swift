//
//  AlamofireRequestModal.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 12/1/2564 BE.
//

import Foundation
import Alamofire

struct AlamofireRequestModal {
    var method: HTTPMethod
    var path: String
    var parameters: [String: AnyObject]?
    var encoding: ParameterEncoding
    var headers: HTTPHeaders

    init() {
        method = .get
        path = ""
        parameters = nil
        encoding = JSONEncoding() as ParameterEncoding
        headers = ["Content-Type": "application/json",
                   "X-Requested-With": "XMLHttpRequest",
                   "Cache-Control": "no-cache"]
    }
}
