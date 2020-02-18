//
//  BookCell.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class BookCell: UICollectionViewCell {
    override func layoutSubviews() {
      super.layoutSubviews()
      self.clipsToBounds = true
      self.layer.cornerRadius = 13
    }
    
    public lazy var bookImageView: UIImageView =    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "book.fill")
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    public lazy var num1Image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "Num1Ribbon")
        imageView.backgroundColor = nil
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    public lazy var noOfWeeksLavel: UILabel =   {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .systemYellow
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 1
        return label
    }()
    
    public lazy var descriptionTextView: UILabel =   {
        let textView = UILabel()
        textView.text = "test textview"
        textView.textAlignment = .center
        textView.numberOfLines = 0
        textView.adjustsFontSizeToFitWidth = true
        textView.backgroundColor = .clear
        return textView
    }()
    
    public func configureCell(for book: Books)    {
        self.descriptionTextView.text = book.description
        self.noOfWeeksLavel.text = "\(book.weeksOnList) weeks on best seller list"
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
        
        setupNum1ImageViewConstraints()
        setupBookImageViewConstraints()
        setupNoOfWeeksLabel()
        setupDescriptionTextViewConstraints()
        
        
    }
    
    private func setupNum1ImageViewConstraints() {
        addSubview(num1Image)
        num1Image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            num1Image.topAnchor.constraint(equalTo: topAnchor),
            num1Image.leadingAnchor.constraint(equalTo: leadingAnchor),
            num1Image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            num1Image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            num1Image.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
        ])
    }

        
    private func setupBookImageViewConstraints()   {
        
        addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            bookImageView.topAnchor.constraint(equalTo: num1Image.topAnchor, constant: 8),
            bookImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            bookImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
        ])
        
    }
    
    
    
        
    private func setupNoOfWeeksLabel()  {
        addSubview(noOfWeeksLavel)
        noOfWeeksLavel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            noOfWeeksLavel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 8),
            noOfWeeksLavel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            noOfWeeksLavel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        
        ])
    }
    
    private func setupDescriptionTextViewConstraints()  {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            descriptionTextView.topAnchor.constraint(equalTo: noOfWeeksLavel.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
        ])
    }
    
}
