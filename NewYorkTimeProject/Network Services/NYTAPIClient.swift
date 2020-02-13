//
//  NYTAPIClient.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import Foundation
import NetworkHelper

struct NYTAPIClient {
    static func getCategories(completion: @escaping (Result<NYTCategory, AppError>) -> ()) {
        let endpoint = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(NYTAPIKey.nytKey)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (results) in
            switch results {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let categoryData):
                do {
                    let categories = try JSONDecoder().decode(NYTCategory.self, from: categoryData)
                    completion(.success(categories))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    static func getBooks(category: NYTCategory, completion: @escaping (Result<NYTimeBook, AppError>) -> ()) {
        let categoryFixed = category.results.first?.listName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "Hardcover%Nonfiction"
        let endpoint = "https://api.nytimes.com/svc/books/v3/lists/current/\(categoryFixed).json?api-key=\(NYTAPIKey.nytKey)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (results) in
            switch results {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let bookData):
                do {
                    let books = try JSONDecoder().decode(NYTimeBook.self, from: bookData)
                    completion(.success(books))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
