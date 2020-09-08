//
//  APIErrorMapperMock.swift
//  github-swift-starsTests
//
//  Created by Vinícius Barcelos on 08/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation
@testable import github_swift_stars

class APIErrorMapperMock: APIErrorMapperProtocol {
    
    var _map: ((Data?, URLResponse?, Error?) -> Result<Data, APIError>)?
    
    func map(data: Data?, response: URLResponse?, error: Error?) -> Result<Data, APIError> {
        _map!(data, response, error)
    }
    

}
