//
//  ReposResponse.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation

struct ReposAPIResponse: Codable {
    var items: [RepoAPIResponse]
    var totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
    }
}

struct RepoAPIResponse: Codable {
    var name: String?
    var description: String?
    var starsCount: Int?
    var owner: OwnerAPIResponse
    
    enum CodingKeys: String, CodingKey {
        case name, description, owner
        case starsCount = "stargazers_count"
    }
}

struct OwnerAPIResponse: Codable {
    var name: String?
    var avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar = "avatar_url"
    }
}
