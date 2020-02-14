//
//  ViewController.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    lazy var favoritesCCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout.init()
       let cv = UICollectionView(frame:.zero , collectionViewLayout: layout)
       layout.scrollDirection = .vertical
       layout.itemSize = CGSize(width: 350, height: 350)
       cv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       cv.register(FavoriteCell.self, forCellWithReuseIdentifier: "FavoritesCVCell")
       cv.dataSource = self
       cv.delegate = self
       return cv
   }()
    
    var favorites = [Books]() {
           didSet {
               favoritesCCollectionView.reloadData()
           }
       }
    
    private func loadFavoritesData() {
        do {
           // favorites = try "INSERT CODE HERE"
        } catch {
            print(error)
            showFavoritesErrorAlert()
        }
    }
    
    private func showFavoritesErrorAlert() {
        _ = showAlert(title: "Error", message: "Favorite could not be added")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }


}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoritesCCollectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCVCell", for: indexPath) as! FavoriteCell
        cell.backgroundColor = .clear
        
        let currentFavorite = favorites[indexPath.row]
        
        let imageURLStr = currentFavorite.bookImage

        
        return cell
    }
    
    
}


