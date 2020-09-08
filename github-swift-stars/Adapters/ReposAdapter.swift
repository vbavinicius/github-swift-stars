//
//  ReposAdapter.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation

protocol ReposAdapterProtocol {
    func adapt(_ response: ReposAPIResponse) -> ReposResponse
    func adapt(_ response: [RepoAPIResponse]) -> [Repo]
    func adapt(_ response: OwnerAPIResponse) -> Owner
}

public struct ReposAdapter: ReposAdapterProtocol {
    
    func adapt(_ response: ReposAPIResponse) -> ReposResponse {
        return ReposResponse(
            items: adapt(response.items),
            totalCount: response.totalCount
        )
    }
    
    func adapt(_ response: [RepoAPIResponse]) -> [Repo] {
        return response.map {
            Repo(name: $0.name,
                description: $0.description,
                starsCount: $0.starsCount,
                owner: adapt($0.owner)
            )
        }
    }
    
    func adapt(_ response: OwnerAPIResponse) -> Owner {
        return Owner(
            name: response.name,
            avatar: response.avatar
        )
    }
    
}
