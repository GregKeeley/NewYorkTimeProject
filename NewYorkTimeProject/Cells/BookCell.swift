//
//  BookCell.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class BookCell: UICollectionViewCell {
    private lazy var bookReuseIdentifier = "bookCell"
    
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
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    public lazy var descriptionTextView: UITextView =   {
        let textView = UITextView()
        textView.text = "test textview"
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()
    
    public func configureCell(for book: Books)    {
        self.titleLabel.text = book.title
        self.descriptionTextView.text = book.description
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
    
    private func commonInit()   {
        setupBookImageViewConstraints()
        setupTitleLabelConstraints()
        setupDescriptionTextViewConstraints()
    }
    
    private func setupBookImageViewConstraints()   {
        
        addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            bookImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            bookImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            bookImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 4/5)
            
        ])
        
    }
    
    private func setupTitleLabelConstraints()   {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            
        ])
        
    }
    
    private func setupDescriptionTextViewConstraints()  {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            //descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            
        ])
    }
    
}
