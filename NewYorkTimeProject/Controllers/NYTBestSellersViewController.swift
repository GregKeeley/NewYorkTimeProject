//
//  NYTBestSellersViewController.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class NYTBestSellersViewController: UIViewController {
    
    let bestsellerView = NYTBestSellersView()
    
    var testCategories = ["Business Books", "Paperback Nonfiction", "Hardcover Nonfiction", "Hardcover Fiction", "Mass Market Paperback"]
    
    var selectedCategory: String?
    
    override func loadView() {
        view = bestsellerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bestsellerView.bestSellerCollectionView.dataSource = self
        bestsellerView.genrePickerView.dataSource = self
        bestsellerView.genrePickerView.delegate = self
    }
    
}

extension NYTBestSellersViewController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath)
        return cell
    }
    
}

extension NYTBestSellersViewController: UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        return testCategories.count
        
    }
    
}

extension NYTBestSellersViewController: UIPickerViewDelegate    {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selected = testCategories[row]
        selectedCategory = selected
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return testCategories[row]
        
    }
    
}


