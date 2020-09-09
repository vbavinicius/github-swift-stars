//
//  ReposServiceMock.swift
//  github-swift-starsTests
//
//  Created by Vinícius Barcelos on 09/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation
@testable import github_swift_stars

class ReposServiceMock: ReposServiceProtocol {
    
    var _swiftRepos: ((Int, (Result<ReposResponse, APIError>) -> Void) -> Void)?
    
    func swiftRepos(fromPage page: Int, completion: @escaping (Result<ReposResponse, APIError>) -> Void) {
        return _swiftRepos!(page, completion)
    }

}
