//
//  ErrorView.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 06/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import UIKit

class ErrorView: UIView, ViewConfigurable {
    
    private var action: (()->Void)?
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Tentar novamente", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    init(errorMessage: String = "") {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupHierarchy()
        setupConstraints()
        
        self.errorMessageLabel.text = errorMessage
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
        stackView.addArrangedSubview(errorMessageLabel)
        stackView.addArrangedSubview(actionButton)
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
        actionButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc
    func buttonAction() {
        if let action = action {
            action()
        }
    }

    func show(
        error: APIError,
        on viewcontroller: UIViewController,
        above aboveView: UIView,
        action: @escaping () -> ())
    {
        errorMessageLabel.text = error.localizedDescription
        self.action = action
        viewcontroller.view.insertSubview(self, aboveSubview: aboveView)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: viewcontroller.view.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: viewcontroller.view.safeAreaLayoutGuide.bottomAnchor),
            leadingAnchor.constraint(equalTo: viewcontroller.view.leadingAnchor),
            trailingAnchor.constraint(equalTo: viewcontroller.view.trailingAnchor)
        ])
        layoutIfNeeded()
    }
}


