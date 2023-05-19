//
//  UserTest.swift
//  GitHubAPIPresenterTests
//
//  Created by Johnatas Rodrigues on 18/05/23.
//

import Foundation
import XCTest
@testable import GitHubAPIPresenter

class UserTests: XCTestCase {
    
    func testUserInitialization() {
        // Given
        let login = "joão"
        let id = 123
        let name = "Fulano"
        let company = "Apple"
        
        // When
        let user = User(login: login, id: id, name: name, company: company)
        
        // Then
        XCTAssertEqual(user.login, login)
        XCTAssertEqual(user.id, id)
        XCTAssertEqual(user.name, name)
        XCTAssertEqual(user.company, company)
    }
    
}

