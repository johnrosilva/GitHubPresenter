//
//  UserServiceTests.swift
//  GitHubAPIPresenterTests
//
//  Created by Johnatas Rodrigues on 18/05/23.
//

import Foundation
import XCTest
@testable import GitHubAPIPresenter

class UserServiceTests: XCTestCase {
    var userService: UserService!

    override func setUp() {
        super.setUp()
        userService = UserService()
    }

    override func tearDown() {
        userService = nil
        super.tearDown()
    }

    func testGetUsers_Successful() {
        // Given
        let expectation = XCTestExpectation(description: "Get users successful")
        var result: Result<[User], Error>?

        // When
        userService.getUsers { res in
            result = res
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
        switch result {
        case .success(let users):
            XCTAssertFalse(users.isEmpty)
        case .failure(let error):
            XCTFail("Error occurred: \(error)")
        case nil:
            XCTFail("No result received")
        }
    }

    func testGetUser_Successful() {
        // Given
        let expectation = XCTestExpectation(description: "Get user successful")
        var result: Result<User, Error>?
        let login = "torvalds"

        // When
        userService.getUser(login: login) { res in
            result = res
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
        switch result {
        case .success(let user):
            XCTAssertEqual(user.login, login)
        case .failure(let error):
            XCTFail("Error occurred: \(error)")
        case nil:
            XCTFail("No result received")
        }
    }

    func testGetUser_Error() {
        // Given
        let expectation = XCTestExpectation(description: "Get user error")
        var result: Result<User, Error>?
        let login = "nonExistentUser"

        // When
        userService.getUser(login: login) { res in
            result = res
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
        switch result {
        case .success:
            XCTFail("Expected failure, but received success")
        case .failure(let error):
            XCTAssertNotNil(error)
        case nil:
            XCTFail("No result received")
        }
    }

    func testGetRepositories_Successful() {
        // Given
        let expectation = XCTestExpectation(description: "Get repositories successful")
        var result: Result<[Repository], Error>?
        let login = "torvalds"

        // When
        userService.getRepositories(login: login) { res in
            result = res
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
        switch result {
        case .success(let repositories):
            XCTAssertFalse(repositories.isEmpty)
        case .failure(let error):
            XCTFail("Error occurred: \(error)")
        case nil:
            XCTFail("No result received")
        }
    }

    func testGetRepositories_Error() {
        // Given
        let expectation = XCTestExpectation(description: "Get repositories error")
        var result: Result<[Repository], Error>?
        let login = "nonExistentUser"

        // When
        userService.getRepositories(login: login) { res in
            result = res
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
        switch result {
        case .success:
            XCTFail("Expected failure, but received success")
        case .failure(let error):
            XCTAssertNotNil(error)
        case nil:
            XCTFail("No result received")
        }
    }
}

