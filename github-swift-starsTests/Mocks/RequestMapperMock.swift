//
//  RequestMapperMock.swift
//  github-swift-starsTests
//
//  Created by Vinícius Barcelos on 08/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation
@testable import github_swift_stars

class RequestMapperMock: RequestMapperProtocol {
    
    var _createRequest: ((APIRoute) -> URLRequest)?
    
    func createRequest(for route: APIRoute) -> URLRequest? {
        return self._createRequest!(route)
    }
}
