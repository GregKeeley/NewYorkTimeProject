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
    
    var defaultSelection: String = "manga"
    
    let bestsellerView = NYTBestSellersView()
        
    private var num1Image = UIImage(named: "Num1Ribbon")
    
    
    var bookCategories = [String](){
        didSet{
            getCategory()
            DispatchQueue.main.async {
                self.bestsellerView.genrePickerView.reloadAllComponents()
                if let currentRow = UserDefaults.standard.object(forKey: UserPreferenceKey.updateSelectedRow.rawValue)  {
                    self.bestsellerView.genrePickerView.selectRow(currentRow as! Int, inComponent: 0, animated: false)
                }
                else {self.bestsellerView.genrePickerView.selectRow(14, inComponent: 0, animated: false)}
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
        loadBooks(category: defaultSelection)
        bestsellerView.bestSellerCollectionView.register(BookCell.self, forCellWithReuseIdentifier: "bookCell")
        navigationItem.title = "NYT Bestseller"
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? BookCell else {
            fatalError("could not cast to cell")
        }
        let book = books[indexPath.row]
        cell.configureCell(for: book)
        if book.rank == 1 {
            cell.num1Image.image = num1Image
            cell.backgroundColor = .yellow
        } else {
            cell.backgroundColor = .white
        }
        return cell
    }
    
}

extension NYTBestSellersViewController: UICollectionViewDelegateFlowLayout   {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        let detailViewController = BookDetailViewController(dataPersistence, book: book)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 0.1
        let maxWidth = UIScreen.main.bounds.size.width
        let numberOfItems: CGFloat = 1
        let totalSpace: CGFloat = numberOfItems * itemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpace) / 1
        return CGSize(width: itemWidth/2, height: itemWidth/1.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 10)
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
