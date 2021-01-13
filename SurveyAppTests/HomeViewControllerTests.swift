//
//  HomeViewControllerTests.swift
//  SurveyAppTests
//
//  Created by Chananchida Fuachai on 13/1/2564 BE.
//

import XCTest
@testable import SurveyApp

class HomeViewControllerTests: XCTestCase {
    
    var viewController: HomeViewController!

    override func setUp() {
        super.setUp()
        viewController = HomeViewController()
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
        XCTAssertNotNil(viewController, "HomeViewController is nil")
    }
}
