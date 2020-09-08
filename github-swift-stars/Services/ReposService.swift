//
//  ReposService.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation

protocol ReposServiceProtocol {
    func swiftRepos(fromPage page: Int, completion: @escaping (Result<ReposResponse, APIError>) -> Void)
}

struct ReposService: ReposServiceProtocol {
    
    let reposAPI: ReposAPIProtocol
    let reposAdapter: ReposAdapter
    
    init(
        reposAPI: ReposAPIProtocol = ReposAPI(),
        reposAdapter: ReposAdapter = ReposAdapter()
    ) {
        self.reposAPI = reposAPI
        self.reposAdapter = reposAdapter
    }
    
    func swiftRepos(fromPage page: Int, completion: @escaping (Result<ReposResponse, APIError>) -> Void) {
        reposAPI.getSwiftRepos(fromPage: page) { result in
            switch result {
            case .success(let reposAPIResponse):
                completion(.success(self.reposAdapter.adapt(reposAPIResponse)))
            case .failure(let apiError):
                completion(.failure(apiError))
            }
        }
    }
}

