//
//  SettingsView.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    public var picker: UIPickerView = {
        let pick = UIPickerView()
        return pick
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func commonInit() {
        
    }
    
    
}
