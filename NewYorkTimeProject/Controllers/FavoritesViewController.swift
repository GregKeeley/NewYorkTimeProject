//
//  ViewController.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesViewController: UIViewController {
    
    private let favoriteBooksView = FavoritesView()
    
    private weak var delegate: FavoriteBookDelegate?
    
    public var dataPersistance: DataPersistence<Books>!
    
    private var favoriteBook = [Books]() {
        
        didSet {
            favoriteBooksView.collectionView.reloadData()
            if favoriteBook.isEmpty {
                favoriteBooksView.collectionView.backgroundView = nil // ADD EMPTY FILE
            } else {
                favoriteBooksView.collectionView.backgroundView = nil
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        view = favoriteBooksView
    }
    
    
    
    private func fetchFavBook() {
        do {
            favoriteBook = try dataPersistance.loadItems()
        } catch {
            showAlert(title: "ERROR", message: "Can't Load Books")
        }
    }
}


extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteBook.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as? FavoriteCell else {
            fatalError("could not downcast cell")
        }
        let favBook = favoriteBook[indexPath.row]
        cell.backgroundColor = .clear
        cell.configureCell(for: favBook)
        cell.delegate = self
        return cell
        
    }
    
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let numberOfItems: CGFloat = 2
        let itemHeight: CGFloat = maxSize.height * 0.30
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // programmatic segue
        let favBook = favoriteBook[indexPath.row]
        let detailVC = BookDetailViewController()
        detailVC.book = favBook
        detailVC.dataPersistence = dataPersistance
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FavoritesViewController: DataPersistenceDelegate {
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchFavBook()
        
    }
    
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchFavBook()
    }
}

extension FavoritesViewController: FavoriteBookDelegate {
    func didSelectMoreButton(_ favBookCell: FavoriteCell, book: Books) {
        print("didSelectMoreButton:\(book.title)")
        
        //MARK:  create an action sheet
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // cancel action
        let cancelAction = UIAlertAction(title: "Canel", style: .cancel)
        alertController.addAction(cancelAction)

        // delete action
        let popUpAction = UIAlertAction(title: "Delete", style: .destructive) { alertAction in
           self.deleteBook(book)
        }
        
        alertController.addAction(popUpAction)
        
        present(alertController, animated: true)
        
    }
    
    private func deleteBook(_ article: Books) {
        guard let index = favoriteBook.firstIndex(of: article) else {
            return
        }
        do {
            try dataPersistance.deleteItem(at: index)
        } catch {
            showAlert(title: "ERROR", message: "Could not delete \(favoriteBook.description)")
          print("error\(error)")
        }
    }
}
