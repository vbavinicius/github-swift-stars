//
//  ReposListViewController.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import UIKit
import Combine

class ReposListViewController: UIViewController {

    private let viewModel: ReposListViewModel
    
    private let refreshControl = UIRefreshControl()
    private let loadingView = LoadingView(loadingMessage: "Carregando repositórios")
    private let errorView = ErrorView(errorMessage: "Erro ao carregar repositórios")
    
    private var bag = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.refreshControl = self.refreshControl
        return tableView
    }()
    
    public init(viewModel: ReposListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
     
     @available(*, unavailable)
     required init?(coder aDecoder: NSCoder) {
         fatalError()
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        setupViews()
        setupHierarchy()
        setupConstraints()
    
        viewModel.getRepos()
    }
    
    @objc func handleTableViewPullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.viewModel.checkNewRepos()
        }
    }
    
    private func bindToViewModel() {
        viewModel.stateSubject.receive(on: DispatchQueue.main).sink { [weak self] state in
            guard let self = self else { return }
            self.resetView()
        
            switch state {
            case .loaded, .loadingMore:
                self.tableView.reloadData()
  
            case .loading:
                self.loadingView.show(on: self, above: self.tableView, animated: true)
                
            case .error:
                if self.viewModel.repos.count == 0 {
                    self.errorView.show(error: APIError.generic, on: self, above: self.tableView) {
                        self.viewModel.getRepos()
                    }
                } else {
                    self.tableView.reloadData()
                }
            case .checkingNewRepos:
                assert(true)
            }
        }.store(in: &bag)
    }
    
    func resetView() {
        self.refreshControl.endRefreshing()
        self.loadingView.removeFromSuperview()
        self.errorView.removeFromSuperview()
    }
}

extension ReposListViewController: ViewConfigurable {
    
    func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setupViews() {
        self.title = "GitHub Swift Top Repositories"
        tableView.register(RepoTableViewCell.self)
        tableView.register(LoadingTableViewCell.self)
        tableView.estimatedRowHeight = 200
        
        refreshControl.addTarget(self, action: #selector(handleTableViewPullToRefresh), for: .valueChanged)
        refreshControl.tintColor = .systemGray
        refreshControl.attributedTitle = NSAttributedString(string: "Buscando repositórios", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        
        view.backgroundColor = .white
    }
}

extension ReposListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.repos.count
        } else {
            return viewModel.state == .loadingMore && viewModel.repos.count > 0 ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension : 50
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 200 : 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.reuseIdentifier, for: indexPath) as? RepoTableViewCell else { return UITableViewCell() }
            cell.set(with: viewModel.repos[indexPath.row])
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.reuseIdentifier, for: indexPath) as? LoadingTableViewCell else { return UITableViewCell() }
            cell.set()
            return cell
        }
    }
}

extension ReposListViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height {
            self.viewModel.getRepos()
        }
    }

}
