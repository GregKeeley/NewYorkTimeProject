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
import SafariServices


class BookDetailViewController: UIViewController {
    
    private var bookDetailView = BookDetailView()
    
    public var dataPersistence: DataPersistence<Books>
    
    private weak var delegate: FavoritesDelegate?
    
    public var book: Books!
    
    init(_ dataPersistence: DataPersistence<Books>, book: Books) {
        self.dataPersistence = dataPersistence
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = bookDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        updateUI()
        configureButtons()
        
    }
    
    private func updateUI() {
        bookDetailView.backgroundColor = .white
        bookDetailView.authorLabel.text = book?.author
        bookDetailView.descriptionLabel.text = book?.description
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
    private func configureButtons() {
        
        bookDetailView.amazonButton.addTarget(self, action: #selector(amazonButtonPressed(_:)), for: .touchUpInside)
        bookDetailView.appleBooksButton.addTarget(self, action: #selector(appleBooksButtonPressed(_:)), for: .touchUpInside)
        bookDetailView.barnesNobelButton.addTarget(self, action: #selector(barnesNobelButtonPressed(_:)), for: .touchUpInside)
        bookDetailView.localStoreButton.addTarget(self, action: #selector(localButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoritesButtonPressed(_:)))
    }
    
    @objc private func favoritesButtonPressed(_ sender: UIBarButtonItem){
        if dataPersistence.hasItemBeenSaved(book) {
            showAlert(title: "Already saved", message: "this book has already been added to your favorites")
            sender.image = UIImage(systemName: "heart.fill")
            return
        }
        delegate?.didSaveBook(book: book)
        
        do {
            try dataPersistence.createItem(book)
            sender.image = UIImage(systemName: "heart.fill")
            showAlert(title: "♥️", message: "\(book?.title ?? "test") was added to your favorites")
        } catch {
            showAlert(title: "Oops", message: "could not save to your favorites \(error)")
        }
    }
    
    @IBAction func amazonButtonPressed(_ sender: UIButton) {
        guard let book = book else {
            return
        }
        let amazon = book.buyLinks[0]
        
        guard let url = URL(string: amazon.url) else {
            return
        }
        let safariPage = SFSafariViewController(url: url)
        present(safariPage, animated: true)
    }
    
    @objc private func appleBooksButtonPressed(_ sender: UIButton) {
        guard let book = book else {
            return
        }
        let appleBooks = book.buyLinks[1]
        
        guard let url = URL(string: appleBooks.url) else {
            return
        }
        let safariPage = SFSafariViewController(url: url)
        present(safariPage, animated: true)
    }
    @objc private func barnesNobelButtonPressed(_ sender: UIButton) {
        guard let book = book else {
            return
        }
        let barnesNobel = book.buyLinks[2]
        
        guard let url = URL(string: barnesNobel.url) else {
            return
        }
        let safariPage = SFSafariViewController(url: url)
        present(safariPage, animated: true)
    }
    @objc private func localButtonPressed(_ sender: UIButton) {
        guard let book = book else {
            return
        }
        let localBS = book.buyLinks[3]
        
        guard let url = URL(string: localBS.url) else {
            return
        }
        let safariPage = SFSafariViewController(url: url)
        present(safariPage, animated: true)
    }
    
    
}

