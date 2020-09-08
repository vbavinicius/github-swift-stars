//
//  APIRouteMock.swift
//  github-swift-starsTests
//
//  Created by Vinícius Barcelos on 08/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation
@testable import github_swift_stars

public struct APIRouteMock: APIRoute, Equatable {

    public var path: String = ""
    public var method: HTTPMethod = .get
    public var queryParams: [String : String]? = [:]
    
    public static var empty: APIRouteMock {
        APIRouteMock(path: "", method: .get, queryParams: [:])
    }
    
    public init(
        path: String = "",
        method: HTTPMethod = .get,
        queryParams: [String : String] = [:]
    ) {
        self.path = path
        self.method = method
        self.queryParams = queryParams
    }
}
