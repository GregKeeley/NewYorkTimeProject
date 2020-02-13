//
//  NewYorkTimeProjectTests.swift
//  NewYorkTimeProjectTests
//
//  Created by Gregory Keeley on 2/9/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import XCTest
import NetworkHelper
@testable import NewYorkTimeProject

class NewYorkTimeProjectTests: XCTestCase {

    func testBookList() {
        let jsonData = """
            {
                "status": "OK",
                "copyright": "Copyright (c) 2020 The New York Times Company.  All Rights Reserved.",
                "num_results": 1,
                "last_modified": "2020-02-06T12:38:02-05:00",
                "results": {
                    "list_name": "Business Books",
                    "list_name_encoded": "business-books",
                    "bestsellers_date": "2020-02-01",
                    "published_date": "2020-02-16",
                    "published_date_description": "latest",
                    "next_published_date": "",
                    "previous_published_date": "2020-01-01",
                    "display_name": "Business",
                    "normal_list_ends_at": 10,
                    "updated": "MONTHLY",
                    "books": [{
                        "rank": 1,
                        "rank_last_week": 0,
                        "weeks_on_list": 0,
                        "asterisk": 0,
                        "dagger": 0,
                        "primary_isbn10": "1250226848",
                        "primary_isbn13": "9781250226846",
                        "publisher": "St. Martin's",
                        "description": "",
                        "price": 0,
                        "title": "LEADERSHIP STRATEGY AND TACTICS",
                        "author": "Jocko Willink",
                        "contributor": "by Jocko Willink",
                        "contributor_note": "",
                        "book_image": "https://s1.nyt.com/du/books/images/9781250226846.jpg",
                        "book_image_width": 330,
                        "book_image_height": 418,
                        "amazon_product_url": "https://www.amazon.com/Leadership-Strategy-Tactics-Field-Manual/dp/1250226848?tag=NYTBS-20",
                        "age_group": "",
                        "book_review_link": "",
                        "first_chapter_link": "",
                        "sunday_review_link": "",
                        "article_chapter_link": "",
                        "isbns": [
                            {
                                "isbn10": "1250226848",
                                "isbn13": "9781250226846"
                            }
                        ],
                        "buy_links": [
                            {
                                "name": "Amazon",
                                "url": "https://www.amazon.com/Leadership-Strategy-Tactics-Field-Manual/dp/1250226848?tag=NYTBS-20"
                            },
                            {
                                "name": "Apple Books",
                                "url": "http://du-gae-books-dot-nyt-du-prd.appspot.com/buy?title=LEADERSHIP+STRATEGY+AND+TACTICS&author=Jocko+Willink"
                            },
                            {
                                "name": "Barnes and Noble",
                                "url": "http://www.anrdoezrs.net/click-7990613-11819508?url=http%3A%2F%2Fwww.barnesandnoble.com%2Fw%2F%3Fean%3D9781250226846"
                            },
                            {
                                "name": "Local Booksellers",
                                "url": "http://www.indiebound.org/book/9781250226846?aff=NYT"
                            }
                        ],
                        "book_uri": "nyt://book/b694a591-a6fa-55b0-914c-14f2e76f73fc"
                    }],
                    "corrections": []
                }
            }
        """.data(using: .utf8)!
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
            let bestSellersDate: String // Will need to be formatted for date
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
            let primaryISBN13: String
            let title: String
            let author: String
            let bookImage: String // URL for book image
            let buyLinks: [BuyLinks]
            private enum CodingKeys: String, CodingKey {
                case rank
                case primaryISBN13 = "primary_isbn13"
                case title
                case author
                case bookImage = "book_image"
                case buyLinks = "buy_links"
            }
        }
        struct BuyLinks: Codable & Equatable {
            let name: String // Company to purchase from
            let url: String // URL to purchase link
        }
        let expectedTitle = "LEADERSHIP STRATEGY AND TACTICS"
        do {
            let nytBook = try JSONDecoder().decode(NYTimeBook.self, from: jsonData)
            let decodedTitle = nytBook.results.books.first?.title ?? ""
            XCTAssertEqual(expectedTitle, decodedTitle)
        } catch {
            XCTFail("decoding error: \(error)")
        }
    }

    func testCategoryList() {
        let jsonData = """
            {
                "status": "OK",
                "copyright": "Copyright (c) 2020 The New York Times Company.  All Rights Reserved.",
                "num_results": 59,
                "results": [{
                    "list_name": "Combined Print and E-Book Fiction",
                    "display_name": "Combined Print & E-Book Fiction",
                    "list_name_encoded": "combined-print-and-e-book-fiction",
                    "oldest_published_date": "2011-02-13",
                    "newest_published_date": "2020-02-16",
                    "updated": "WEEKLY"
                }]
            }
        """.data(using: .utf8)!
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
        let expectedTitle = "Combined Print and E-Book Fiction"
        do {
            let nytCat = try JSONDecoder().decode(NYTCategory.self, from: jsonData)
            let decodedTitle = nytCat.results.first?.listName ?? ""
            XCTAssertEqual(expectedTitle, decodedTitle)
        } catch {
            XCTFail("decoding error: \(error)")
        }
    }
 
}
