//
//  UserDetailViewModelTests.swift
//  GitHubAPIPresenterTests
//
//  Created by Johnatas Rodrigues on 18/05/23.
//

import XCTest
@testable import GitHubAPIPresenter

class UserDetailViewModelTests: XCTestCase {
    var userService: MockUserService?
    var viewModel: UserDetailViewModel?
    var mockUser: User {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "user_mock", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            XCTFail("Failed to load mock user data.")
            return User()
        }
        return user
    }
    var mockRepositories: [Repository] {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "repos_mock", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let repositories = try? JSONDecoder().decode([Repository].self, from: data) else {
            XCTFail("Failed to load mock repositories data.")
            return []
        }
        return repositories
    }

    override func setUp() {
        super.setUp()
        userService = MockUserService()
        viewModel = UserDetailViewModel(userService: userService ?? UserService(),
                                        user: mockUser)
    }

    override func tearDown() {
        userService = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchData_Successful() {
        // Given
        let user = mockUser
        let repositories = mockRepositories
        userService?.getUserResult = .success(user)
        userService?.getRepositoriesResult = .success(repositories)

        // When
        viewModel?.fetchData()

        // Then
        XCTAssertFalse(viewModel?.isLoading ?? false)
        XCTAssertFalse(viewModel?.isErrored ?? true)
        XCTAssertEqual(viewModel?.user.id, user.id)
        XCTAssertEqual(viewModel?.repositories.count, repositories.count)
        XCTAssertFalse(viewModel?.isLoading ?? true)
    }

    func testFetchData_UserError() {
        // Given
        let expectedError = MockError.mockFailure
        userService?.getUserResult = .failure(expectedError)

        // When
        viewModel?.fetchData()

        // Then
        XCTAssertFalse(viewModel?.isLoading ?? true)
        XCTAssertTrue(viewModel?.isErrored ?? false)
        XCTAssertEqual(viewModel?.userError, expectedError.localizedDescription)
        XCTAssertFalse(viewModel?.isLoading ?? true)
    }

    func testFetchData_RepositoriesError() {
        // Given
        let expectedError = MockError.mockFailure
        userService?.getRepositoriesResult = .failure(expectedError)

        // When
        viewModel?.fetchData()

        // Then
        XCTAssertFalse(viewModel?.isLoading ?? true)
        XCTAssertTrue(viewModel?.isErrored ?? false)
        XCTAssertEqual(viewModel?.userError, expectedError.localizedDescription)
        XCTAssertFalse(viewModel?.isLoading ?? true)
    }
}

