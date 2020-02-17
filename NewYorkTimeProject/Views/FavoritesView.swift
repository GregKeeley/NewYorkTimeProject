//
//  FavoritesView.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//
import UIKit

class FavoritesView: UIView {
    
//    weak var delegate: FavoritesDelegate?
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 250, height: 250)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = #colorLiteral(red: 0.9633663297, green: 0.8417919278, blue: 0.7775592804, alpha: 1)
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    
    private func commonInit(){
        backgroundColor = .systemBackground
        collectionViewConstraints()
    }
    
    func collectionViewConstraints(){
        
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
//            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
    }
}

