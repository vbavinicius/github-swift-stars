

//
//  UITableView+Extensions.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
      register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
