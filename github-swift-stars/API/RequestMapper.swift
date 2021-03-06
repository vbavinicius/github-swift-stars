//
//  RequestMapper.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation

protocol RequestMapperProtocol {
    func createRequest(for route: APIRoute) -> URLRequest?
}

struct RequestMapper: RequestMapperProtocol {

    let baseURLString: String

    init(baseURLString: String = Environment.host) {
        self.baseURLString = baseURLString
    }
    
    func createRequest(for route: APIRoute) -> URLRequest? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURLString
        urlComponents.path = route.path
        if route.queryParams != [:] {
            urlComponents.queryItems = route.queryParams?.map { (key, value) -> URLQueryItem in
                URLQueryItem(name: key, value: value)
            }
        }

        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue
        if GitHubAPIKey.key != "YOUR KEY HERE" {
            request.setValue("token \(GitHubAPIKey.key)", forHTTPHeaderField: "Authorization")
        }
    
        return request
    }
}
