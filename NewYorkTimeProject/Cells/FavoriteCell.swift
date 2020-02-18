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
    
    override func layoutSubviews() {
      super.layoutSubviews()
      self.clipsToBounds = true
      self.layer.cornerRadius = 13
    }
    
    public lazy var bookImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    public lazy var optionButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.actions, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(optionsButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var weeksLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AmericanTypewriter-CondensedBold", size: 20.0)
        label.text = "Number of Weeks"
        return label
    }()
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        super.init(frame: UIScreen.main.bounds)
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
        descriptionLabelConstraints()
    }
    
    @objc func optionsButtonPressed(_ sender: UIButton) {
        delegate?.didSelectMoreButton(self, book: currentFav)
    }
    
    private func optionButtonConstraints() {
        addSubview(optionButton)
        optionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            optionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            optionButton.heightAnchor.constraint(equalToConstant: safeAreaLayoutGuide.layoutFrame.width / 12),
            optionButton.widthAnchor.constraint(equalTo: optionButton.heightAnchor)
        ])
    }
    
    private func bookImageConstraints() {
        addSubview(bookImage)
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            bookImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            bookImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            bookImage.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
            // Original
            //            bookImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            //            bookImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            //            bookImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            //            bookImage.widthAnchor.constraint(equalToConstant: (bookImage.image?.size.width ?? 1) * 0.5)

        ])
    }
    
    private func weeksLabelConstraints() {
        addSubview(weeksLabel)
        weeksLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            weeksLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weeksLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 10),
            weeksLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            
        ])
    }
    
    private func favTexViewConstraints() {
        addSubview(favTextView)
        favTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            
            
        ])
    }
    private func descriptionLabelConstraints() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            descriptionLabel.topAnchor.constraint(equalTo: weeksLabel.bottomAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            
        ])
    }
    
    public func configureCell(for favBook: Books) {
        currentFav = favBook // associating the cell with its Book
        favTextView.text = favBook.description
        weeksLabel.text = ("\(favBook.weeksOnList) weeks on best seller list")
        descriptionLabel.text = favBook.description
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
