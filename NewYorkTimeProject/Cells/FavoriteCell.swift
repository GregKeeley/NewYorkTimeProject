//
//  FavoriteCell.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit


class FavoriteCell: UICollectionViewCell {
        
    var selectedBook: Books!
    
    lazy var bookImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var optionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        return button
    }()
    
    lazy var weeksLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Number of Weeks"
        return label
    }()
    
   lazy var favTextView: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .white
    textView.isEditable = false
    return textView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        optionButtonConstraints()
        bookImageConstraints()
        weeksLabelConstraints()
    }
    
    
    private func optionButtonConstraints() {
        addSubview(optionButton)
        optionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionButton.topAnchor.constraint(equalTo: topAnchor),
            optionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            optionButton.heightAnchor.constraint(equalToConstant: 44),
            optionButton.widthAnchor.constraint(equalTo: optionButton.heightAnchor)
        ])
    }
    
    private func bookImageConstraints() {
        addSubview(bookImage)
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: optionButton.bottomAnchor, constant: 10),
            bookImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            bookImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func weeksLabelConstraints() {
        addSubview(weeksLabel)
        weeksLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weeksLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weeksLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weeksLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weeksLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
