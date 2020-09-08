//
//  LoadingView.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 06/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import UIKit

class LoadingView: UIView, ViewConfigurable {
    
    private let loadingMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    init(loadingMessage: String = "") {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupViews()
        setupHierarchy()
        setupConstraints()
        
        self.loadingMessageLabel.text = loadingMessage
    }
    
    @available(*, unavailable)
    public override init(frame: CGRect) {
        fatalError()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupHierarchy() {
        stackView.addArrangedSubview(activityIndicatorView)
        stackView.addArrangedSubview(loadingMessageLabel)
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setupViews() {
        backgroundColor = .white
        activityIndicatorView.startAnimating()
    }

    func show(on viewcontroller: UIViewController, above aboveView: UIView, animated: Bool) {
        viewcontroller.view.insertSubview(self, aboveSubview: aboveView)
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: viewcontroller.view.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: viewcontroller.view.safeAreaLayoutGuide.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: viewcontroller.view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: viewcontroller.view.trailingAnchor)
        ])
        self.layoutIfNeeded()
    }
}


