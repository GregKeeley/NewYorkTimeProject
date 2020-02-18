//
//  CustomDelegate.swift
//  NewYorkTimeProject
//
//  Created by casandra grullon on 2/14/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import Foundation

protocol FavoritesDelegate: AnyObject {
    func didSaveBook(book: Books)
}

