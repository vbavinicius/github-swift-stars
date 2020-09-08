//
//  Repos.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 06/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation

struct ReposResponse: Equatable {
    let items: [Repo]
    let totalCount: Int?
}

struct Repo {
    var name: String?
    var description: String?
    var starsCount: Int?
    var owner: Owner
}

struct Owner {
    var name: String?
    var avatar: String?
}

extension Repo: Equatable {
    static func == (lhs: Repo, rhs: Repo) -> Bool {
        return lhs.name == rhs.name &&
            lhs.description == rhs.description &&
            lhs.starsCount == rhs.starsCount &&
            lhs.owner == rhs.owner
    }
}

extension Owner: Equatable {
    static func == (lhs: Owner, rhs: Owner) -> Bool {
        return lhs.name == rhs.name
    }
}
