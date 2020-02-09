//
//  BookDetailViewController.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    private var bookDetailView = BookDetailView()
    
    override func loadView() {
        view = bookDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoritesButtonPressed(_:)))
    }
    
    @objc private func favoritesButtonPressed(_ sender: UIBarButtonItem){
        sender.image = UIImage(systemName: "heart.fill")
        print("added to favorites")
        //TODO: Add data persistence to save book to favorites
    }

    

}
