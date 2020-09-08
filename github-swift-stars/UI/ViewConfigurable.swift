//
//  ViewConfigurable.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation

protocol ViewConfigurable {
    func setupHierarchy()
    func setupConstraints()
    func setupViews()
}
