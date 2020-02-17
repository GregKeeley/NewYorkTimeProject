//
//  SettingsViewController.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

//TODO: refactor to tab bar later
public enum UserPreferenceKey: String {
    case selectedCatergory = "Category"
    case updateSelectedRow = "Selected Row"
}

class SettingsViewController: UIViewController {

    private var settingsView = SettingsView()
    
    private var selectedCategory: String?
    
    private var bookCategories = [String]()
    
    override func loadView() {
        view = settingsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        settingsView.picker.delegate = self
        settingsView.picker.dataSource = self
        loadCategories()
    }
    
    private func loadCategories() {
        NYTAPIClient.getCategories { [weak self] (result) in
            switch result {
            case .failure(let appError):
                self?.showAlert(title: "could not populate data", message: "\(appError)")
            case .success(let catergories):
                self?.bookCategories = catergories.results.map{$0.listName}
            }
        }
    }
    

}
extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = bookCategories[row]
        selectedCategory = selected
        UserDefaults.standard.set(selected, forKey: UserPreferenceKey.selectedCatergory.rawValue)
        UserDefaults.standard.set(row, forKey: UserPreferenceKey.updateSelectedRow.rawValue)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bookCategories[row]
    }
}
extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bookCategories.count
    }
    
    
}

