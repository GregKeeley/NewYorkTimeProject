//
//  BookDetailViewController.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit
import DataPersistence
import ImageKit

class BookDetailViewController: UIViewController {

    private var bookDetailView = BookDetailView()
    
    private var dataPersistence: DataPersistence<Books>!
    
    private weak var delegate: FavoritesDelegate?
    
    private var book: Books?
    
    override func loadView() {
        view = bookDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        updateUI()
    }
    
    private func updateUI() {
        bookDetailView.authorLabel.text = book?.author
        bookDetailView.descriptionLabel.text = "Greg needs to add this"
        bookDetailView.titleLabel.text = book?.title
        bookDetailView.bookImage.getImage(with: book?.bookImage ?? "") { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.bookDetailView.bookImage.image = UIImage(systemName: "book")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.bookDetailView.bookImage.image = image
                }
            }
        }
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoritesButtonPressed(_:)))
    }
    
    @objc private func favoritesButtonPressed(_ sender: UIBarButtonItem){
        sender.image = UIImage(systemName: "heart.fill")
        
        guard let book = book else {
            return
        }
        showAlert(title: "♥️", message: "\(book.title) was added to your favorites")
        delegate?.didSaveBook(book: book)
        
        do {
            try dataPersistence.createItem(book)
        } catch {
            showAlert(title: "Oops", message: "could not save to your favorites \(error)")
        }
    }

    

}
