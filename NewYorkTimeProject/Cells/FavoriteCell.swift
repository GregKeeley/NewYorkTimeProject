//
//  FavoriteCell.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

protocol FavoriteBookDelegate: AnyObject {
    func didSelectMoreButton(_ favBookCell: FavoriteCell, book: Books)
}

class FavoriteCell: UICollectionViewCell {
    
    private var currentFav: Books!
    
    weak var delegate: FavoriteBookDelegate?
    
    lazy var bookImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var optionButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.actions, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        return button
    }()
    
    lazy var weeksLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AmericanTypewriter-CondensedBold", size: 20.0)
        label.text = "Number of Weeks"
        return label
    }()
    
   lazy var favTextView: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .white
    textView.text = "Book Detail Text"
    textView.font = UIFont(name: "AmericanTypewriter", size: 15)
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
            bookImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bookImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func weeksLabelConstraints() {
        addSubview(weeksLabel)
        weeksLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            weeksLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weeksLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weeksLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weeksLabel.bottomAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 20)
        ])
    }
    
    private func favTexViewConstraints() {
        addSubview(favTextView)
        favTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favTextView.topAnchor.constraint(equalTo: weeksLabel.bottomAnchor, constant: 10),
            favTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            favTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
        ])
    }
    
    public func configureCell(for favBook: Books) {
        currentFav = favBook // associating the cell with its Book
        favTextView.text = favBook.description
        self.bookImage.getImage(with: favBook.bookImage) { (result) in
            switch result   {
            case .failure(let appError):
                print(appError)
            case .success(let bookImage):
                DispatchQueue.main.async {
                    self.bookImage.image = bookImage
                    
                }
            }
        }
    }
}
