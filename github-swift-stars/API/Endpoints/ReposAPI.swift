//
//  ReposAPI.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation

protocol ReposAPIProtocol {
    func getSwiftRepos(fromPage page: Int, completion: @escaping (Result<ReposAPIResponse, APIError>) -> Void)
}

struct ReposAPI: ReposAPIProtocol {
    
    let client: APIClientProtocol
    
    init(
        client: APIClientProtocol = APIClient()
    ) {
        self.client = client
    }
    
    func getSwiftRepos(fromPage page: Int, completion: @escaping (Result<ReposAPIResponse, APIError>) -> Void) {
        
        let route = ReposAPIRoute.getSwiftRepos(page: page)
        
        client.request(route, returnQueue: .main) { result in
            switch result {
            case .success(let data):
                do {
                    let reposAPIResponse = try JSONDecoder().decode(ReposAPIResponse.self, from: data)
                    completion(.success(reposAPIResponse))
                } catch {
                    completion(.failure(APIError.invalidData))
                }
            case .failure(let apiError):
                 completion(.failure(apiError))
            }
        }
        
    }
}

