//
//  APIError.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation

enum APIError: Error {
    case notConnectedToInternet
    case invalidData
    case generic
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notConnectedToInternet:
            return "Parece que você está sem conexão"
        case .invalidData, .generic:
            return "Algo de errado aconteceu"
        }
    }
}

