//
//  APIErrorMapperTests.swift
//  github-swift-starsTests
//
//  Created by Vinícius Barcelos on 08/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import XCTest
@testable import github_swift_stars

class APIErrorMapperTests: XCTestCase {

    var sut: APIErrorMapper!
    
    override func setUp() {
        super.setUp()
        self.sut = APIErrorMapper()
    }
    
    func test_returnSuccess_whenReceivedValidData() {
        let expectedData = Data(repeating: 10, count: 10)
        
        let result = sut.map(
            data: expectedData,
            response: HTTPURLResponse(
                url: URL(string: "https://apple.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            ), error: nil)
        
        switch result {
        case .success(let data):
            XCTAssertEqual(expectedData, data)
        default:
            XCTFail()
        }
    }
    
    func test_returnSuccess_whenReceived200StatusCode() {
        let result = sut.map(
            data: Data(repeating: 10, count: 10),
            response: HTTPURLResponse(
                url: URL(string: "https://apple.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            ), error: nil)
        
        switch result {
        case .success(_):
            XCTAssert(true)
        default:
            XCTFail()
        }
    }
    
    func test_returnFailure_whenReceivedInvalidData() {
        let expectedAPIError = APIError.generic
        let receivedResult = self.sut.map(data: nil, response: nil, error: nil)
    
        switch receivedResult {
        case .success:
            XCTFail()
        case .failure(let receivedError):
            XCTAssertEqual(receivedError, expectedAPIError)
        }
    }
    
    func test_returnFailure_whenReceived400StatusCode() {
        let result = sut.map(
            data: Data(repeating: 10, count: 10),
            response: HTTPURLResponse(
                url: URL(string: "https://apple.com")!,
                statusCode: 400,
                httpVersion: nil,
                headerFields: nil
            ), error: nil)
        
        switch result {
        case .success(_):
            XCTFail()
        default:
            XCTAssert(true)
        }
    }
    
}
