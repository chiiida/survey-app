//
//  LoginViewControllerTests.swift
//  SurveyAppTests
//
//  Created by Chananchida Fuachai on 13/1/2564 BE.
//

import XCTest
import UIKit
@testable import SurveyApp

class LoginViewControllerTests: XCTestCase {

    var viewController: LoginScreenViewController!
    
    override func setUp() {
        super.setUp()
        viewController = LoginScreenViewController()
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testViewDidload() {
        viewController.viewDidLoad()
    }
    
    func testLoginViewController() {
        XCTAssertNotNil(viewController, "LoginViewController is nil")
    }
    
    func testEmailTextField_WhenCreated_HasEmailAddressContentTypeSet() throws {
        let emailTextField = try XCTUnwrap(viewController.emailField, "Email address UITextField is not connected")
        
        XCTAssertEqual(emailTextField.textContentType, UITextContentType.emailAddress, "Email address UITextField does not have an Email Address Content Type set")
    }

}
