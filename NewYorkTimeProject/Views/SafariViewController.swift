//
//  SafariViewController.swift
//  NewYorkTimeProject
//
//  Created by casandra grullon on 2/14/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class SafariViewController: UIViewController {

    var url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
