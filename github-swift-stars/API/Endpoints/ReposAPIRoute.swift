//
//  ReposAPIRoute.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation

enum ReposAPIRoute: APIRoute {
    
    case getSwiftRepos(page: Int)
    
    var path: String {
        switch self {
        case .getSwiftRepos:
            return "/search/repositories"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case let .getSwiftRepos(page):
            return ["q": "language:swift", "sort": "stars", "page": "\(page)"]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSwiftRepos:
            return .get
        }
    }
        

    
}
