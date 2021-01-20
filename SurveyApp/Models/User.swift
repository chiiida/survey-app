//
//  User.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 6/1/2564 BE.
//

import Foundation

struct UserAtrributes: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    let refresh_token: String
    let created_at: Int
}

struct User: Codable {
    let id: Int
    let type: String
    let attributes: UserAtrributes
}

struct AuthResponse: Codable {
    let data: User
}
