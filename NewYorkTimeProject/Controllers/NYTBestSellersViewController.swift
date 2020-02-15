//
//  NYTBestSellersViewController.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit
import DataPersistence

class NYTBestSellersViewController: UIViewController {
    
    private var dataPersistence: DataPersistence<Books>
        
    var defaultSelection: String = "manga" {
        didSet  {
            navigationItem.title = defaultSelection
        }
    }
    
    let bestsellerView = NYTBestSellersView()
    
    var bookCategories = [String](){
        didSet{
            DispatchQueue.main.async {
                self.bestsellerView.genrePickerView.reloadAllComponents()
            }
        }
    }
    
    var books = [Books]()  {
        didSet  {
            DispatchQueue.main.async {
                self.bestsellerView.bestSellerCollectionView.reloadData()
            }
        }
    }
    
    init(_ dataPersistence: DataPersistence<Books>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = bestsellerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadPickerView()
        bestsellerView.bestSellerCollectionView.dataSource = self
        bestsellerView.bestSellerCollectionView.delegate = self
        bestsellerView.genrePickerView.dataSource = self
        bestsellerView.genrePickerView.delegate = self
        loadBooks(category: "manga")
        bestsellerView.bestSellerCollectionView.register(BookCell.self, forCellWithReuseIdentifier: "bookCell")
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            getCategory()
        }
        
    private func loadPickerView()   {
        NYTAPIClient.getCategories { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let categories):
                self?.bookCategories = categories.results.map{$0.listName}
            }
        }
    }
    
    private func loadBooks(category: String)    {
        NYTAPIClient.getBooks(category: category) { (result) in
            switch result   {
            case .failure(let appError):
                print(appError)
            case .success(let book):
                self.books = book.results.books
            }
        }
    }
    
    private func getCategory(for category: String = "manga")  {
        if let defaultCategory = UserDefaults.standard.object(forKey: UserPreferenceKey.selectedCatergory.rawValue) as? String  {
            if defaultCategory != self.defaultSelection {
                loadBooks(category: defaultCategory)
                self.defaultSelection = defaultCategory
            }   else    {
                loadBooks(category: defaultCategory)
            }
            
        }   else    {
            loadBooks(category: defaultSelection)
        }
        
    }
    
}

extension NYTBestSellersViewController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? BookCell
        let book = books[indexPath.row]
        cell?.configureCell(for: book)
        return cell!
    }
    
}

extension NYTBestSellersViewController: UICollectionViewDelegate    {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        let detailViewController = BookDetailViewController(dataPersistence, book: book)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension NYTBestSellersViewController: UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bookCategories.count
    }
    
}

extension NYTBestSellersViewController: UIPickerViewDelegate    {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = bookCategories[row]
        loadBooks(category: selected)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bookCategories[row]
    }
}


