//
//  NewsCellViewModelTests.swift
//  ExpressNewsTests
//
//  Created by Kavita Thorat on 03/02/24.
//

import XCTest
@testable import LloydsAssignmentNewsApp

final class NewsCellViewModelTests: XCTestCase {
    var viewModel: NewsCellViewModel?
    var news: ArticleDomainModel?
    

    override func setUp() {
        super.setUp()
        news = ArticleDomainModel(id: nil, source: "The Washington Post", title: "13-year-old becomes first known person to ‘beat’ Tetris - The Washington Post", description: "Willis Gibson, 13, became the first person known to have beat “Tetris” by getting so far into the game he made it freeze.", url: "https://www.washingtonpost.com/nation/2024/01/04/13-year-old-beats-tetris/", urlToImage: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440", urlToThumbnail: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440",  publishedAt: "2024-01-05T05:44:15Z")
        if let newsArticle = news {
            viewModel = NewsCellViewModel(news: newsArticle, imageUseCase:UseCaseFactory.createImageUseCase(isMock: true))
        }
    }

    override func tearDown() {
        viewModel = nil
        news = nil
        super.tearDown()
    }


    func testGetNews() {
        XCTAssertEqual(viewModel?.getNews(), news)
    }

    func testNewsTitle() {
        XCTAssertEqual(viewModel?.newsTitle(), news?.title)
    }

    func testNewsAuthorAndSource() {
        XCTAssertEqual(viewModel?.newsAuthorAndSource(), news?.newsSource)
    }
}

extension ArticleDomainModel: Equatable {
    public static func == (lhs: ArticleDomainModel, rhs: ArticleDomainModel) -> Bool {
        return lhs.url == rhs.url
    }
    
}
