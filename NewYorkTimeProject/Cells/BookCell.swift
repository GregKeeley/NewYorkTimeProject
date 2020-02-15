//
//  BookCell.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class BookCell: UICollectionViewCell {
    
    public lazy var bookImageView: UIImageView =    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "book.fill")
        return imageView
    }()
    
    public lazy var titleLabel: UILabel =   {
        let label = UILabel()
        label.text = "test label"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    public lazy var descriptionTextView: UILabel =   {
        let textView = UILabel()
        textView.text = "test textview"
        textView.textAlignment = .center
        textView.numberOfLines = 1
        return textView
    }()
    
    public func configureCell(for book: Books)    {
        self.titleLabel.text = book.title
        self.descriptionTextView.text = "\(book.weeksOnList) weeks on Best Sellers List"
        self.bookImageView.getImage(with: book.bookImage) { (result) in
            switch result   {
            case .failure(let appError):
                print(appError)
            case .success(let bookImage):
                DispatchQueue.main.async {
                    self.bookImageView.image = bookImage

                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupTitleLabelConstraints()
        setupBookImageViewConstraints()
        setupDescriptionTextViewConstraints()
    }
    
    private func setupTitleLabelConstraints()   {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
            
        ])
        
    }
    private func setupBookImageViewConstraints()   {
        
        addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            bookImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bookImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            bookImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
        
    }
    private func setupDescriptionTextViewConstraints()  {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            descriptionTextView.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            
        ])
    }
    
}
