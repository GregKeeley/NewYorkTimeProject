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

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //TODO: fix hard coded number
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //TODO: fix hard coded number --> add data.count
        return 1
    }
    
    
}
