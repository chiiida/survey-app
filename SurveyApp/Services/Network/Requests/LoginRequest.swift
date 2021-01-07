//
//  LoginRequest.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 6/1/2564 BE.
//

import Foundation

struct LoginRequest: Encodable {
    let grant_type: String
    let email: String
    let password: String
    let client_id: String
    let client_secret: String
}
