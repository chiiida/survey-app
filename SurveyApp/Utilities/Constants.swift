//
//  Constants.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 6/1/2564 BE.
//

import Foundation
import UIKit

// URL Constants
let BASE_URL = "https://survey-api.nimblehq.co/"
let URL_LOGIN = "\(BASE_URL)api/v1/oauth/token"
let URL_LOGOUT = "\(BASE_URL)api/v1/oauth/revoke"
let URL_SURVEY_LIST = "\(BASE_URL)api/v1/surveys?page[number]=1&page[size]=5"
let URL_USER = "\(BASE_URL)api/v1/me"

// Color code
let DARK_GRAY = UIColor(red: 0.5882, green: 0.5686, blue: 0.5686, alpha: 1.0)
let LIGHT_GRAY = UIColor(red: 0.7176, green: 0.7176, blue: 0.7176, alpha: 1.0)
