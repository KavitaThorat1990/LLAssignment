//
//  NewsDetailsViewModelTests.swift
//  ExpressNewsTests
//
//  Created by Kavita Thorat on 03/02/24.
//

import XCTest
@testable import LloydsAssignmentNewsApp

final class NewsDetailsViewModelTests: XCTestCase {
    var viewModel: NewsDetailsViewModel?
    var news: ArticleDomainModel?
    

    override func setUp() {
        super.setUp()
        news = ArticleDomainModel(id: nil, source: "The Washington Post", title: "13-year-old becomes first known person to ‘beat’ Tetris - The Washington Post", description: "Willis Gibson, 13, became the first person known to have beat “Tetris” by getting so far into the game he made it freeze.", url: "https://www.washingtonpost.com/nation/2024/01/04/13-year-old-beats-tetris/", urlToImage: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440", urlToThumbnail: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-05-2024/t_01e058b5fa3f40aa8666709c2fa9fbbc_name_nintendo.jpg&w=1440",  publishedAt: "2024-01-05T05:44:15Z")
        if let newsArticle = news {
            viewModel = NewsDetailsViewModel(newsArticle: newsArticle, imageUseCase: UseCaseFactory.createImageUseCase(isMock: true))
        }
    }
    
    override func tearDown() {
        viewModel = nil
        news = nil
        super.tearDown()
    }
    
    func testLoadImageSuccess() {
        let loadImageExpectation = XCTestExpectation(description: "Image loaded successfully")
        // When
        viewModel?.loadImage()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Adjust the timeout as needed
            XCTAssertNotNil(self.viewModel?.downloadedImage)
            loadImageExpectation.fulfill()
        }

        wait(for: [loadImageExpectation], timeout: 10.0)
    }

    func testNewsImageUrl() {
        // When
        let url = viewModel?.newsImageUrl()

        // Then
        XCTAssertEqual(url, news?.imageUrl)
    }

    func testNewsTitle() {
        // When
        let title = viewModel?.newsTitle()

        // Then
        XCTAssertEqual(title, news?.title)
    }

    func testNewsPublishedAt() {
        // When
        let publishedAt = viewModel?.newsPublishedAt()

        // Then
        XCTAssertEqual(publishedAt, news?.updatedAt)
    }

    func testNewsAuthorAndSource() {
        // When
        let authorAndSource = viewModel?.newsAuthorAndSource()

        // Then
        XCTAssertEqual(authorAndSource, news?.newsSource)
    }

    func testNewsDescription() {
        // When
        let description = viewModel?.newsDescription()

        // Then
        XCTAssertEqual(description, news?.description)
    }

    func testNewsUrl() {
        // When
        let url = viewModel?.newsUrl()

        // Then
        XCTAssertEqual(url, URL(string: news?.url ?? ""))
    }
}
