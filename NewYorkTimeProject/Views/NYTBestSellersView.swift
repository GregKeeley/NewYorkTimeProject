//
//  NYTBestSellersView.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class NYTBestSellersView: UIView {

    public lazy var bestSellerCollectionView: UICollectionView =    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: "bookCell")
        collectionView.backgroundColor = #colorLiteral(red: 0, green: 0.7813991904, blue: 0.4538331628, alpha: 1)
        return collectionView
    }()
    
    public lazy var genrePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit()   {
        setupCollectionViewConstraints()
        setupPickerViewConstraints()
    }
    
    private func setupCollectionViewConstraints() {
        
        addSubview(bestSellerCollectionView)
        bestSellerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bestSellerCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            bestSellerCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bestSellerCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bestSellerCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func setupPickerViewConstraints() {
        addSubview(genrePickerView)
        genrePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            genrePickerView.topAnchor.constraint(equalTo: bestSellerCollectionView.bottomAnchor),
            genrePickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            genrePickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            genrePickerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    
}
