//
//  BookDetailView.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class BookDetailView: UIView {
    
    private var currentBook: Books?
    
    public lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0

        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    public lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0

        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    public lazy var buyButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [amazonButton, appleBooksButton, barnesNobelButton, localStoreButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
    public lazy var amazonButton: UIButton = {
        let button = UIButton()
        button.setTitle("Amazon", for: .normal)
        return button
    }()
    public lazy var appleBooksButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apple Books", for: .normal)
        return button
    }()
    public lazy var barnesNobelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Barnes & Nobel", for: .normal)
        return button
    }()
    public lazy var localStoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Local Bookstores", for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        bookImageConstraints()
        buttonStackConstraints()
        titleLabelConstraints()
        authorLabelConstraints()
        descriptionLabelConstraints()
    }
    
    private func bookImageConstraints() {
        addSubview(bookImage)
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            bookImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3),
            
        ])
    }
    private func buttonStackConstraints() {
        addSubview(buyButtonStack)
        buyButtonStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buyButtonStack.topAnchor.constraint(equalTo: bookImage.topAnchor),
            buyButtonStack.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 8)
//            buyButtonStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
//            buyButtonStack.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 8),
//            buyButtonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    private func titleLabelConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    private func authorLabelConstraints() {
        addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    private func descriptionLabelConstraints() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
}

