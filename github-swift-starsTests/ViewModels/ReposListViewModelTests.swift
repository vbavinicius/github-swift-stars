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
    
    override func setUp() {
        sut = ReposListViewModel()
    }
    
    func test_currentWillChange_afterSuccessfullRequest() {

        let expectedPage = 3
        let exp = expectation(description: "current page will be updated")
        
        sut.currentPageDidChanged = { page in
            exp.fulfill()
        }
        sut.currentReposPage = 2
        sut.getRepos()
        
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(sut.currentReposPage, expectedPage)
    }

}
