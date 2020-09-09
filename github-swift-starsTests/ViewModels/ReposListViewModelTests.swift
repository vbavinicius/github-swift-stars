//
//  ReposListViewModelTests.swift
//  github-swift-starsTests
//
//  Created by Vinícius Barcelos on 08/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import XCTest
@testable import github_swift_stars


class ReposListViewModelTests: XCTestCase {
    
    var sut: ReposListViewModel!
    var reposServiceMock: ReposServiceMock!
    
    override func setUp() {
        reposServiceMock = ReposServiceMock()
        sut = ReposListViewModel(reposService: reposServiceMock)
    }
    
    func test_currentPageWillNotChange_afterFailureRequest() {

        let expectedPage = 2
        sut.currentReposPage = 2
        let exp = expectation(description: "")
        
        reposServiceMock._swiftRepos = { page, result in
            result(.failure(APIError.generic))
            exp.fulfill()
        }
        
        sut.getRepos()
        
        wait(for: [exp], timeout: 5)
        
        XCTAssertEqual(sut.currentReposPage, expectedPage)
    }
    
    func test_currentPageWillChange_afterSuccessfullRequest() {

        let repoResponse = ReposResponse(items: [], totalCount: 1)
        let exp = expectation(description: "")
        
        self.reposServiceMock._swiftRepos = { page, result in
            result(.success(repoResponse))
            exp.fulfill()
        }
        
        sut.currentReposPage = 2
        sut.getRepos()
        
        wait(for: [exp], timeout: 5)
        
        XCTAssertEqual(sut.currentReposPage, 3)
    }

}
