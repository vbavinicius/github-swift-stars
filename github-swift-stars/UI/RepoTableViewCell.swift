//
//  RepoTableViewCell.swift
//  github-swift-stars
//
//  Created by Vinícius Barcelos on 04/09/20.
//  Copyright © 2020 Vinícius Barcelos. All rights reserved.
//

import UIKit
import Kingfisher

class RepoTableViewCell: UITableViewCell {

    let DEFAULT_PADDING: CGFloat = 16
    let PROFILE_IMAGE_SIZE: CGFloat = 24
    
    private let repoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "vsouza/awesome-ios"
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let repoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "A curated list of awesome iOS ecosystem, including Objective-C and Swift Projects"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        label.textColor = .systemGray
        return label
    }()
    
    private let repoStarsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.text = "★ 35583"
        label.textColor = .systemGray
        return label
    }()
    
    private let repoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        return stackView
    }()
    
    private let repoAuthorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "vsouza"
        label.textColor = .systemGray
        return label
    }()
    
    private let repoAuthorImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let repoAuthorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        repoTitleLabel.text = ""
        repoDescriptionLabel.text = ""
        repoStarsLabel.text = "★"
        repoAuthorNameLabel.text = ""
        repoAuthorImageView.image = UIImage(named: "profile")
    }
}

extension RepoTableViewCell: ViewConfigurable {
    
    internal func setupHierarchy() {
        repoStackView.addArrangedSubview(repoTitleLabel)
        repoStackView.addArrangedSubview(repoDescriptionLabel)
        repoStackView.addArrangedSubview(repoStarsLabel)
        self.addSubview(repoStackView)
        
        repoAuthorStackView.addArrangedSubview(repoAuthorImageView)
        repoAuthorStackView.addArrangedSubview(repoAuthorNameLabel)
        self.addSubview(repoAuthorStackView)
    }
    
    internal func setupConstraints() {
        NSLayoutConstraint.activate([
            repoStackView.topAnchor.constraint(equalTo: topAnchor, constant: DEFAULT_PADDING),
            repoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DEFAULT_PADDING),
            repoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DEFAULT_PADDING),
  
            repoAuthorImageView.heightAnchor.constraint(equalToConstant: PROFILE_IMAGE_SIZE),
            repoAuthorImageView.widthAnchor.constraint(equalToConstant: PROFILE_IMAGE_SIZE),
            
            repoAuthorStackView.topAnchor.constraint(equalTo: repoStackView.bottomAnchor, constant: 12),
            repoAuthorStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DEFAULT_PADDING),
            repoAuthorStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DEFAULT_PADDING),
            repoAuthorStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -DEFAULT_PADDING),
        ])
    }
    
    internal func setupViews() {
        repoAuthorImageView.layer.cornerRadius = PROFILE_IMAGE_SIZE / 2
        repoAuthorImageView.layer.masksToBounds = true
    }
    
}

extension RepoTableViewCell {
    
    func set(with repo: Repo) {
        repoTitleLabel.text = repo.name
        repoDescriptionLabel.text = repo.description
        repoStarsLabel.text = "★ \(repo.starsCount ?? 0)"
        repoAuthorNameLabel.text = repo.owner.name ?? "Error on get author name"
        repoAuthorImageView.set(repo.owner.avatar ?? "", withPlaceholder: "profile")
    }
    
}
