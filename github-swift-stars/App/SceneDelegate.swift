//
//  SceneDelegate.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = (scene as? UIWindowScene) {
            let window = UIWindow(windowScene: windowScene)
            
            let reposListViewModel = ReposListViewModel()
            let reposListViewController = ReposListViewController(viewModel: reposListViewModel)
            let navigationController = UINavigationController(rootViewController: reposListViewController)

            window.rootViewController = navigationController
            window.backgroundColor = .white
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}

