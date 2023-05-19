//
//  UITest.swift
//  GitHubAPIPresenterUITests
//
//  Created by Johnatas Rodrigues on 18/05/23.
//

import Foundation

import XCTest

class UserUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("Testing")
        app.launch()
    }
    
    func testUserListView() throws {
        XCTAssertTrue(app.waitForExistence(timeout: 5), "Failed to load user list")
        
        XCTAssertTrue(app.navigationBars["Users"].exists, "Incorrect navigation bar title")
        
        XCTAssertTrue(app.cells.count > 0, "User cells not found")
        
        let firstCell = app.cells.element(boundBy: 0)
        firstCell.tap()
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        XCTAssertTrue(app.navigationBars["Users"].exists, "Failed to navigate back to user list")
    }
    
    func testUserDetailView() throws {
        XCTAssertTrue(app.waitForExistence(timeout: 5), "Failed to load user list")
        
        XCTAssertTrue(app.navigationBars["Users"].exists, "Incorrect navigation bar title")
        
        XCTAssertTrue(app.cells.count > 0, "User cells not found")
        
        let firstCell = app.cells.element(boundBy: 0)
        firstCell.tap()
        
        XCTAssertTrue(app.navigationBars["Linus Torvalds"].exists, "Incorrect navigation bar title")
        
        XCTAssertTrue(app.staticTexts["torvalds"].exists, "User name not found")
        XCTAssertTrue(app.staticTexts["Followers: 182.816"].exists, "User followers count not found")
        XCTAssertTrue(app.staticTexts["Public Repositories: 7"].exists, "User repositories count not found")
    }
}

