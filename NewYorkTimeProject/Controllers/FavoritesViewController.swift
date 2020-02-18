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
    
    public var dataPersistance: DataPersistence<Books>
    
    private var favoriteBook = [Books]() {
        
        didSet {
            favoriteBooksView.collectionView.reloadData()
            if favoriteBook.isEmpty {
                favoriteBooksView.collectionView.backgroundView = EmptyView.init(title: "Collection Empty", message: "There are currently no saved books")
            } else {
                favoriteBooksView.collectionView.reloadData()
                favoriteBooksView.collectionView.backgroundView = nil
            }
        }
    }
    
    init(_ dataPersistence: DataPersistence<Books>) {
        self.dataPersistance = dataPersistence
        super.init(nibName: nil, bundle: nil)
        self.dataPersistance.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = favoriteBooksView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteBooksView.collectionView.dataSource = self
        favoriteBooksView.collectionView.delegate = self
        favoriteBooksView.collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: "favCell")
        fetchFavBook()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchFavBook()
    }
    
    private func fetchFavBook() {
        do {
            favoriteBook = try dataPersistance.loadItems()
        } catch {
            showAlert(title: "ERROR", message: "Can't Load Books \(error)")
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
        cell.backgroundColor = .white
        cell.configureCell(for: favBook)
        cell.delegate = self
        return cell
        
    }
    
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        return CGSize(width: (maxSize.width * 0.95), height: (maxSize.height * 0.50))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // programmatic segue
        let favBook = favoriteBook[indexPath.row]
        let detailVC = BookDetailViewController(dataPersistance, book: favBook)
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
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        // delete action
        let popUpAction = UIAlertAction(title: "Delete", style: .destructive) { alertAction in
           self.deleteBook(book)
        }
        
        alertController.addAction(popUpAction)
        
        present(alertController, animated: true)
        
    }
    
    private func deleteBook(_ book: Books) {
        guard let index = favoriteBook.firstIndex(of: book) else {
            return
        }
        do {
            try dataPersistance.deleteItem(at: index)
            showAlert(title: "Deleted", message: "successfully deleted \(book.title) from your collection")
        } catch {
            showAlert(title: "ERROR", message: "Could not delete \(book.title)")
        }
    }
}
