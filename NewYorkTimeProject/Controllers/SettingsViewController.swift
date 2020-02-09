//
//  SettingsViewController.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    private var settingsView = SettingsView()
    
    var testCategories = ["Business Books", "Paperback Nonfiction", "Hardcover Nonfiction", "Hardcover Fiction", "Mass Market Paperback"]
    
    var selectedCategory: String?
    
    override func loadView() {
        view = settingsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        settingsView.picker.delegate = self
        settingsView.picker.dataSource = self
    }
    
    //TODO: add API data for categories
    

}
extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = testCategories[row]
        selectedCategory = selected
        //TODO: add UserDefaults to save selected category
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return testCategories[row]
    }
}
extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return testCategories.count
    }
    
    
}

