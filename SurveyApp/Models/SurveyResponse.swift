//
//  SurveyResponse.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 20/1/2564 BE.
//

import Foundation

struct SurveyAttributes: Codable {
    let title: String
    let description: String
    let thank_email_above_threshold: String?
    let thank_email_below_threshold: String?
    let is_active: Bool
    let cover_image_url: String
    let created_at: String
    let active_at: String
    let inactive_at: String?
    let survey_type: String
}

struct SurveyQuestionData: Codable {
    let id: String
    let type: String
}

struct SurveyQuestion: Codable {
    let data: [SurveyQuestionData]
}

struct SurveyRelationships: Codable {
    let questions: SurveyQuestion
}

struct SurveyData: Codable {
    let id: String
    let type: String
    let attributes: SurveyAttributes
    let relationships: SurveyRelationships
}

struct Meta: Codable {
    let page: Int
    let pages: Int
    let page_size: Int
    let records: Int
}

struct SurveyResponse: Codable {
    let data: [SurveyData]
    let meta: Meta
}
