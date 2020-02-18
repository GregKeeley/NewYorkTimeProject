//
//  NYTBook.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

struct NYTimeBook: Codable & Equatable {
    
    let numResults: Int
    let results: Results
    
    private enum CodingKeys: String, CodingKey {
        case numResults = "num_results"
        case results
    }
}

struct Results: Codable & Equatable {
    
    let listName: String
    let bestSellersDate: String
    let displayName: String
    let books: [Books]
    
    private enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case bestSellersDate = "bestsellers_date"
        case displayName = "display_name"
        case books
    }
    
}

struct Books: Codable & Equatable {
    
    let rank: Int
    let weeksOnList: Int
    let primaryISBN13: String
    let description: String?
    let title: String
    let author: String
    let bookImage: String
    let buyLinks: [BuyLinks]
    
    private enum CodingKeys: String, CodingKey {
        case rank
        case weeksOnList = "weeks_on_list"
        case primaryISBN13 = "primary_isbn13"
        case description
        case title
        case author
        case bookImage = "book_image"
        case buyLinks = "buy_links"
    }
}

struct BuyLinks: Codable & Equatable {
    let name: String
    let url: String
}
