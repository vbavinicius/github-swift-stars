//
//  ReposAdapterTests.swift
//  github-swift-starsTests
//
//  Created by Vinícius Barcelos on 08/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import XCTest
@testable import github_swift_stars

class ReposAdapterTests: XCTestCase {

    var sut: ReposAdapter!
    
    var model: ReposResponse!
    var response: ReposAPIResponse!

    override func setUp() {
        sut = ReposAdapter()
        
        model = ReposResponse(items: [
            Repo(
                name: "teste",
                description: "teste",
                starsCount: 100,
                owner: Owner(
                    name: "teste",
                    avatar: "teste"))
        ], totalCount: 1)

        response = ReposAPIResponse(items: [
            RepoAPIResponse(
                name: "teste",
                description: "teste",
                starsCount: 100,
                owner: OwnerAPIResponse(
                    name: "teste",
                    avatar: "teste")
            )
        ], totalCount: 1)
    }

    func test_adaptToModel() {
        let adapter = sut.adapt(response)
        XCTAssertEqual(adapter, model)
    }
    
}
