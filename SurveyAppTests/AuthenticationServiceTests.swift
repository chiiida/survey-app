//
//  AuthenticationServiceTests.swift
//  SurveyAppTests
//
//  Created by Chananchida Fuachai on 13/1/2564 BE.
//

import XCTest
@testable import SurveyApp

class AuthenticationServiceTests: XCTestCase {
    
    var authService: AuthenticationService!

    override func setUp() {
        super.setUp()
//        let manager = managerMock
        authService = AuthenticationService()
    }
    
    override func tearDown() {
        authService = nil
        super.tearDown()
    }
    
    func testLogin() {
        let testEmail = "test@gmail.com"
        let testPassword = "12345678"
        
        let expectation = XCTestExpectation(description: "Performs a request")
        
        authService.login(email: testEmail, password: testPassword) { (success) in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
    }
    
}
