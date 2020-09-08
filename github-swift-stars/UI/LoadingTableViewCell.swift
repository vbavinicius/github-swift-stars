//
//  LoadingTableViewCell.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 07/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    let DEFAULT_PADDING: CGFloat = 16
    
    private let loadingMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.text = "Buscando mais repositórios"
        return label
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension LoadingTableViewCell: ViewConfigurable {
    
    func setupHierarchy() {
        containerView.addSubview(activityIndicatorView)
        containerView.addSubview(loadingMessageLabel)
        addSubview(containerView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: DEFAULT_PADDING),
            containerView.trailingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: -DEFAULT_PADDING),
            
            activityIndicatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loadingMessageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: DEFAULT_PADDING),
            loadingMessageLabel.leadingAnchor.constraint(equalTo: activityIndicatorView.trailingAnchor, constant: DEFAULT_PADDING / 2),
            loadingMessageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -DEFAULT_PADDING),
            loadingMessageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -DEFAULT_PADDING)
        ])
    }
    
    func setupViews() {
        backgroundColor = .white
    }
}

extension LoadingTableViewCell {
    func set() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
    }
}
