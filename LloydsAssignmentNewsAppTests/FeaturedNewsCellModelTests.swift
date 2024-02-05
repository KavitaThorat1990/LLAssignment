//
//  FeaturedNewsCellModelTests.swift
//  ExpressNewsTests
//
//  Created by Kavita Thorat on 03/02/24.
//

import XCTest
@testable import LloydsAssignmentNewsApp

final class FeaturedNewsCellModelTests: XCTestCase {
    
    var cellModel = FeaturedNewsCellViewModel()

    override func setUp() {
        super.setUp()
        let newsArticle1 = ArticleDomainModel(id: nil, source: "The Washington Post", title: "13-year-old becomes first known person to ‘beat’ Tetris - The Washington Post", description: "Willis Gibson, 13, became the first person known to have beat “Tetris” by getting so far into the game he made it freeze.", url: "https://www.washingtonpost.com/nation/2024/01/04/13-year-old-beats-tetris/", urlToImage: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440", urlToThumbnail: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440",  publishedAt: "2024-01-05T05:44:15Z")
        
        let newsArticle2 = ArticleDomainModel(id: nil, source: "The Washington Post", title: "13-year-old becomes first known person to ‘beat’ Tetris - The Washington Post", description: "Willis Gibson, 13, became the first person known to have beat “Tetris” by getting so far into the game he made it freeze.", url: "https://www.washingtonpost.com/nation/2024/01/04/13-year-old-beats-tetris/", urlToImage: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440", urlToThumbnail: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440",  publishedAt: "2024-01-05T05:44:15Z")
        let payload = [Constants.PayloadKeys.newsList: [newsArticle1, newsArticle2]]
        cellModel.configure(payload: payload)
    }
    
    func testConfigureWithValidPayload() {
        XCTAssertEqual(cellModel.getNumberOfRows(), 2)
        XCTAssertNotNil(cellModel.getNewsForRow(index: 0))
        XCTAssertNil(cellModel.getNewsForRow(index: 4))
    }

    func testConfigureWithEmptyPayload() {
        let payload: [String: Any] = [Constants.PayloadKeys.newsList: []]
        cellModel.configure(payload: payload)

        XCTAssertEqual(cellModel.getNumberOfRows(), 0)
        XCTAssertNil(cellModel.getNewsForRow(index: 0))
    }
}
