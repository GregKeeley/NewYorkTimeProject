//
//  NYTCategory.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/9/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import Foundation

struct NYTCategory: Codable & Equatable {
    let numResults: Int
    let results: [CatResults]
    private enum CodingKeys: String, CodingKey {
        case numResults = "num_results"
        case results
    }
}
struct CatResults: Codable & Equatable {
    let listName: String
    let displayName: String
    let updated: String
    private enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case updated
    }
}
