//
//  RequestMapperTests.swift
//  github-swift-starsTests
//
//  Created by Vinícius Barcelos on 08/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import XCTest
@testable import github_swift_stars

class RequestMapperTests: XCTestCase {
    
    func test_createRequest_UsesCorrectBaseURL() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "apple.com"
        let expectedBaseURL = urlComponents.url
        
        let sut = RequestMapper(
            baseURLString: "apple.com"
        )
        
        let urlRequest = sut.createRequest(for: APIRouteMock.empty)
        
        XCTAssertEqual(urlRequest?.url, expectedBaseURL)
    }
    
    func test_createRequest_UsesCorrectHTTPMethod() {
        let expectedMethod = HTTPMethod.get
        
        let sut = RequestMapper(
            baseURLString: "apple.com"
        )
        
        let urlRequest = sut.createRequest(for: APIRouteMock(path: "", method: expectedMethod, queryParams: [:]))
        
        XCTAssertEqual(urlRequest?.httpMethod, expectedMethod.rawValue)
    }

}
