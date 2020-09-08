//
//  APIClient.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation

protocol APIClientProtocol {
    func request(_ route: APIRoute, returnQueue: DispatchQueue?, completion: @escaping (Result<Data, APIError>) -> Void)
}

public struct APIClient: APIClientProtocol {
        
    private let requestMapper: RequestMapperProtocol
    private let apiErrorMapper: APIErrorMapperProtocol

    init(
        requestMapper: RequestMapperProtocol = RequestMapper(),
        apiErrorMapper: APIErrorMapperProtocol = APIErrorMapper()
    ) {
        self.requestMapper = requestMapper
        self.apiErrorMapper = apiErrorMapper
    }

    func request(_ route: APIRoute, returnQueue: DispatchQueue?, completion: @escaping (Result<Data, APIError>) -> Void) {
        guard let request = self.requestMapper.createRequest(for: route) else {
            returnQueue?.async {
                completion(.failure(APIError.generic))
            }
            return
        }
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            let mappedResult = self.apiErrorMapper.map(data: data, response: response, error: error)
            returnQueue?.async {
                completion(mappedResult)
            }
        }
        dataTask.resume()
    }
}
