//
//  SettingsView.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    override func layoutSubviews() {
      super.layoutSubviews()
      settingsButton.clipsToBounds = true
      settingsButton.layer.cornerRadius = 13
    }
    
    public lazy var settingsLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "settings"
        return label
    }()
    
    public lazy var picker: UIPickerView = {
        let pick = UIPickerView()
        return pick
    }()
    
    public lazy var settingsButton: UIButton = {
       let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.7581976056, blue: 0.4109169245, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        settingsLabelConstraints()
        pickerConstraints()
        buttonConstraints()
    }
    
    private func settingsLabelConstraints() {
        addSubview(settingsLabel)
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            settingsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            settingsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    private func pickerConstraints() {
        addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            picker.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            picker.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    private func buttonConstraints() {
        addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 10),
            settingsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}
