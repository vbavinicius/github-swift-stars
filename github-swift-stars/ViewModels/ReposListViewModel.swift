//
//  ReposListViewModel.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 07/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import Foundation
import Combine

class ReposListViewModel {
    
    enum State: Equatable {
        case loaded, loading, loadingMore, error, checkingNewRepos
    }
    
    var state: State = .loaded {
        didSet { stateSubject.send(state) }
    }

    var repos: [Repo] = []
    var currentReposPage: Int = 1
    var currentPageDidChanged: ((Int)->())?
    private var currentReposResponse: ReposResponse? {
        didSet {
            repos.append(contentsOf: currentReposResponse?.items ?? [])
        }
    }

    let stateSubject = PassthroughSubject<State, Never>()
    private var bag = Set<AnyCancellable>()
    
    private let reposService: ReposServiceProtocol
    
    public init(reposService: ReposServiceProtocol = ReposService()) {
        self.reposService = reposService
    }
}

extension ReposListViewModel {
    
    private func fetchRepos(fromPage page: Int, completion: @escaping (Result<ReposResponse, APIError>) -> Void) {
        DispatchQueue.main.async {
            self.reposService.swiftRepos(fromPage: page) { result in
                switch result {
                case .success(let reposResponse):
                    completion(.success(reposResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getRepos() {
        guard self.state == .error || self.state == .loaded else {return}
        self.state = repos.count == 0 ? .loading : .loadingMore
        self.fetchRepos(fromPage: self.currentReposPage) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let reposResponse):
                self.currentReposResponse = reposResponse
                self.currentReposPage += 1
                self.currentPageDidChanged?(self.currentReposPage + 1)
                self.state = .loaded
            case .failure(_):
                self.state = .error
            }
        }
    }

    func checkNewRepos() {
        guard self.state == .error || self.state == .loaded else {return}
        self.state = .checkingNewRepos
        self.fetchRepos(fromPage: 1) { [weak self] result in
            switch result {
            case .success(let reposResponse):
                guard let slice = self?.repos.prefix(30), reposResponse.items != Array(slice) else {
                    self?.state = .loaded
                    return
                }
                self?.repos = []
                self?.currentReposResponse = reposResponse
                self?.currentReposPage = 2
                self?.state = .loaded
            case .failure(_):
                self?.state = .loaded
            }
        }
    }

}
