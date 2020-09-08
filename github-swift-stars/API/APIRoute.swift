//
//  APIRoute.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation

public protocol APIRoute {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParams: [String: String]? { get }
}
