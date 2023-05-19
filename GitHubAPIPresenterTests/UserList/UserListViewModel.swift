//
//  UserListViewModel.swift
//  GitHubAPIPresenterTests
//
//  Created by Johnatas Rodrigues on 18/05/23.
//

import Foundation
import XCTest
@testable import GitHubAPIPresenter

class UserListViewModelTests: XCTestCase {
    var userService: MockUserService = MockUserService()
    var viewModel: UserListViewModel?
    var mockUsers: [User] {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "users_mock", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let users = try? JSONDecoder().decode([User].self, from: data) else {
            XCTFail("Failed to load mock users data.")
            return []
        }
        return users
    }

    override func setUp() {
        super.setUp()
        userService = MockUserService()
        viewModel = UserListViewModel(userService: userService)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchUsers_Successful() {
        // Given
        userService.getUsersResult = .success(mockUsers)

        // When
        viewModel?.fetchUsers()

        // Then
        XCTAssertFalse(viewModel?.isLoading ?? true)
        XCTAssertEqual(viewModel?.users.count, mockUsers.count)
        XCTAssertFalse(viewModel?.isLoading ?? true)
        XCTAssertFalse(viewModel?.isErrored ?? true)
        XCTAssertEqual(viewModel?.userError, "")
    }

    func testFetchUsers_Error() {
        // Given
        let expectedError = NSError(domain: "TestDomain", code: 123, userInfo: nil)
        userService.getUsersResult = .failure(expectedError)

        // When
        viewModel?.fetchUsers()

        // Then
        XCTAssertFalse(viewModel?.isLoading ?? true)
        XCTAssertTrue(viewModel?.isErrored ?? false)
        XCTAssertEqual(viewModel?.userError, expectedError.localizedDescription)
        XCTAssertFalse(viewModel?.isLoading ?? true)
        XCTAssertTrue(viewModel?.users.isEmpty ?? false)
    }

    func testSearchText_FilterUsers() {
        // Given
        userService.getUsersResult = .success(mockUsers)

        // When
        viewModel?.fetchUsers()
        viewModel?.searchText = "mojo"

        // Then
        XCTAssertEqual(viewModel?.users.count ?? 0, 30)
        XCTAssertTrue(viewModel?.users.contains(where: { $0.login == "mojombo" }) ?? false)
        XCTAssertTrue(viewModel?.users.contains(where: { $0.login == "mojodna" }) ?? false)
        XCTAssertTrue(viewModel?.users.contains(where: { $0.login == "errfree" }) ?? true)
    }
    
    func testSearchTextDidSet() {
        // Given
        viewModel?.users = mockUsers
        viewModel?.fetchedUsers = mockUsers
        
        // When
        viewModel?.searchText = "m"
        
        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel?.users.count ?? 0, 8)
        }
        
        // When
        viewModel?.searchText = "mo"
        
        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel?.users.count ?? 0, 4)
        }
        
        // When
        viewModel?.searchText = ""
        
        // Then
        XCTAssertEqual(viewModel?.users.count ?? 0, 30)
    }
}

