//
//  Enviroment.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation

public enum Environment {
    public static let host: String = {
        guard let value = Environment.infoDictionary["HOST"] as? String else { fatalError() }
        return value
    }()
}

private extension Environment {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary, let envConfig = dict["EnvironmentConfig"] as? [String: Any] else { fatalError() }
        return envConfig
    }()
}

